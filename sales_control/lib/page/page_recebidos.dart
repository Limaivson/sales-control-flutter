// ignore_for_file: library_private_types_in_public_api, use_super_parameters, library_prefixes
import 'package:flutter/material.dart';
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/page/adicionar_cliente.dart';
import 'package:sales_control/external/obter_clientes.dart' as listaClientes;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecebidosScreen(),
    );
  }
}

class RecebidosScreen extends StatefulWidget {
  const RecebidosScreen({Key? key}) : super(key: key);

  @override
  _RecebidosScreenState createState() => _RecebidosScreenState();
}

class _RecebidosScreenState extends State<RecebidosScreen> {
  late Future<List<Cliente>> clientesFuture;
  final TextEditingController _valorController = TextEditingController();
  String _selectedClient = '';
  late List<Cliente> _clientesFiltrados = [];

  @override
  void initState() {
    super.initState();
    clientesFuture = listaClientes.ObterListaClientes().obterClientes(false);
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

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registrar Pagamento'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text('Cliente: ${cliente.nome}'),
                const SizedBox(height: 20),
                TextField(
                  controller: _valorController,
                  decoration: const InputDecoration(labelText: 'Valor do pagamento'),
                ),
              ],
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
              onPressed: () {
                if (_valorController.text.isNotEmpty) {
                  // Aqui você pode implementar a lógica para registrar o pagamento
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pagamento registrado com sucesso')),
                  );
                  Navigator.of(context).pop();
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
                Text('Endereço: ${cliente.endereco}'),
                Text('Telefone: ${cliente.telefone}'),
                Text('Pagamento: ${cliente.pagamento.valor}'),
                Text('Data de Recebimento: ${cliente.pagamento.dataPagamento}'),
                Text('Data do Pagamento: ${cliente.pagamento.dataRealizacaoPagamento}'),
                Text('Funcionário: ${cliente.funcionario.nome}'),
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
}
