// ignore_for_file: library_private_types_in_public_api, use_super_parameters, library_prefixes, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/external/realizar_pagamento.dart';
import 'package:sales_control/page/adicionar_cliente.dart';
import 'package:sales_control/external/obter_clientes.dart' as listaClientes;
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FiadosScreen(),
    );
  }
}

class FiadosScreen extends StatefulWidget {
  const FiadosScreen({Key? key}) : super(key: key);

  @override
  _FiadosScreenState createState() => _FiadosScreenState();
}

class _FiadosScreenState extends State<FiadosScreen> {
  late Future<List<Cliente>> clientesFuture;
  final TextEditingController _valorController = TextEditingController();
  String _selectedClient = '';
  late List<Cliente> _clientesFiltrados = [];

  @override
  void initState() {
    super.initState();
    clientesFuture = listaClientes.ObterListaClientes().obterClientes(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _selectedClient = value;
                  _filtrarClientes(value); // Não precisamos esperar pelo resultado, pois estamos atualizando a lista localmente
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: FutureBuilder<List<Cliente>>(
            future: clientesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text('Erro ao carregar os clientes');
              } else {
                List<Cliente> clientes = snapshot.data!;
                List<Cliente> clientesParaExibir = _selectedClient.isNotEmpty ? _clientesFiltrados : clientes;
                return ListView(
                  children: clientesParaExibir.map((cliente) {
                    return InkWell(
                      onTap: () {
                        _mostrarDetalhesCliente(context, cliente);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[700],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cliente.nome,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    cliente.endereco,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.attach_money, color: Colors.white),
                                onPressed: () {
                                  _mostrarPopupPagamento(context, cliente);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarClienteScreen(onAddClient: (newCliente) {
              setState(() {
                // Aqui você pode atualizar a lista de clientes após adicionar um novo cliente
              });
            })),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _filtrarClientes(String searchTerm) {
    clientesFuture.then((clientes) {
      setState(() {
        _clientesFiltrados = clientes.where((cliente) => cliente.nome.toLowerCase().contains(searchTerm.toLowerCase())).toList();
      });
    });
  }

  Future<void> _mostrarPopupPagamento(BuildContext context, Cliente cliente) async {
  _valorController.clear();

  String emailLogado = await _obterEmailLogado();

showDialog<void>(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: const Text('Registrar Pagamento'),
      content: SingleChildScrollView(
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('${cliente.nome} está pagando ao funcionário $emailLogado'),
                const SizedBox(height: 20),
                TextField(
                  controller: _valorController,
                  decoration: const InputDecoration(labelText: 'Valor do pagamento'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text('Pagamento Completo:'),
                    Switch(
                      value: cliente.pagamento.pago,
                      onChanged: (newValue) {
                        setState(() {
                          cliente.pagamento.pago = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async{
            if (_valorController.text.isNotEmpty) {
              await pagar(cliente.id, _valorController.text, context, cliente.pagamento.pago);
              Navigator.of(context).pop();
              if (cliente.pagamento.pago) {
              setState(() {
                clientesFuture = listaClientes.ObterListaClientes().obterClientes(true);
              });}
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Por favor, preencha todos os campos')),
              );
            }
          },
          child: const Text('Registrar'),
        ),
      ],
    );
  },
);
}



  Future<String> _obterEmailLogado() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser != null){
      
      return auth.currentUser!.email!;
    }
    return '';
  }

  void _mostrarDetalhesCliente(BuildContext context, Cliente cliente) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(cliente.nome),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFormattedText(cliente.endereco, 'Endereço: '),
              _buildFormattedText(cliente.telefone, 'Telefone: '),
              _buildFormattedText(cliente.pagamento.valor, 'Pagamento: '),
              _buildFormattedText(cliente.dataCompra, 'Data da Compra: '),
              _buildFormattedText(cliente.pagamento.dataPagamento, 'Data de Recebimento: '),
              _buildFormattedText(cliente.pagamento.dataRealizacaoPagamento == '' ? cliente.pagamento.dataRealizacaoPagamento : 'Não realizado', 'Data do Pagamento: '),
              _buildFormattedText(cliente.funcionario.nome, 'Funcionário: '),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar'),
          ),
        ],
      );
    },
  );
}

Widget _buildFormattedText(String content, String label) {
  return content.isEmpty
      ? const SizedBox.shrink() // Se o conteúdo estiver vazio, retorna um widget vazio
      : Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Alinha o conteúdo verticalmente ao centro
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold), // Estilo para o rótulo
            ),
            const SizedBox(width: 4), // Espaçamento entre o rótulo e o conteúdo
            Container(
              padding: const EdgeInsets.all(8), // Espaçamento interno do frame
              decoration: BoxDecoration(
                color: Colors.blueGrey[700], // Cor de fundo do frame
                borderRadius: BorderRadius.circular(8), // Borda arredondada do frame
              ),
              child: Text(
                content,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Estilo para o conteúdo variável
              ),
            ),
            const SizedBox(width: 12, height: 40), // Espaçamento à direita do frame
          ],
        );
}

}
