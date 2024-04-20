// ignore_for_file: library_private_types_in_public_api, use_super_parameters, library_prefixes

import 'package:flutter/material.dart';
import 'package:sales_control/page/adicionar_cliente.dart';
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/external/obter_clientes.dart' as listaClientes;

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
  String _selectedFuncionario = '';
  final List<String> _funcionarios = ['Selecione um funcionário', 'Funcionário 1', 'Funcionário 2', 'Funcionário 3'];

  @override
  void initState() {
    super.initState();
    clientesFuture = listaClientes.ObterListaClientes().obterClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900], // Cor do AppBar
        title: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _selectedClient = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
                labelStyle: TextStyle(color: Colors.white), // Cor do texto da label
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey[100], // Cor de fundo da janela
      body: Padding(
        padding: const EdgeInsets.all(50.0),
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
                return SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Nome')),
                      DataColumn(label: Text('Endereço')),
                      DataColumn(label: Text('Telefone')),
                    ],
                    rows: clientes
                        .where((cliente) => cliente.nome.toLowerCase().contains(_selectedClient.toLowerCase()))
                        .map((cliente) {
                      return DataRow(
                        cells: [
                          DataCell(
                            InkWell(
                              onTap: () {
                                _mostrarPopupPagamento(context, cliente);
                              },
                              child: Text(cliente.nome),
                            ),
                          ),
                          DataCell(Text(cliente.endereco)),
                          DataCell(Text(cliente.telefone)),
                        ],
                      );
                    }).toList(),
                  ),
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

  Future<void> _mostrarPopupPagamento(BuildContext context, Cliente cliente) async {
    _valorController.clear();
    _selectedFuncionario = _funcionarios.first;

    return showDialog<void>(
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
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedFuncionario,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedFuncionario = newValue!;
                    });
                  },
                  items: _funcionarios.map((funcionario) {
                    return DropdownMenuItem<String>(
                      value: funcionario,
                      child: Text(funcionario),
                    );
                  }).toList(),
                  decoration: const InputDecoration(labelText: 'Selecione o funcionário'),
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
                if (_valorController.text.isNotEmpty && _selectedFuncionario != _funcionarios.first) {
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
}
