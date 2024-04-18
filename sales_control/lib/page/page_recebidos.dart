// ignore_for_file: prefer_const_literals_to_create_immutables, library_private_types_in_public_api, library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sales_control/page/adicionar_cliente.dart';
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/external/obter_clientes.dart' as listaClientes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecebidosScreen(),
    );
  }
}

class RecebidosScreen extends StatefulWidget {
  const RecebidosScreen({super.key});

  @override
  _RecebidosScreenState createState() => _RecebidosScreenState();
}

class _RecebidosScreenState extends State<RecebidosScreen> {
  late Future<List<Cliente>> clientesFuture;

  @override
  void initState() {
    super.initState();
    clientesFuture = listaClientes.ObterListaClientes().obterClientesRecebidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recebidos'),
      ),
      body: Center(
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
                  columns: [
                    const DataColumn(label: Text('Nome')),
                    const DataColumn(label: Text('Endereço')),
                    const DataColumn(label: Text('Telefone')),
                    const DataColumn(label: Text('Funcionário')),
                    const DataColumn(label: Text('Pagamento')),
                    const DataColumn(label: Text('Tipo de Pagamento')),
                    const DataColumn(label: Text('Data')),
                  ],
                  rows: clientes.map((cliente) {
                    return DataRow(cells: [
                      DataCell(Text(cliente.nome)),
                      DataCell(Text(cliente.endereco)),
                      DataCell(Text(cliente.telefone)),
                      DataCell(Text(cliente.funcionario.nome)),
                      DataCell(Text(cliente.pagamento.valor.toString())),
                      DataCell(Text(cliente.pagamento.tipoPagamento)),
                      DataCell(Text(cliente.pagamento.data.toString())),
                    ]);
                  }).toList(),
                ),
              );
            }
          },
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
}
