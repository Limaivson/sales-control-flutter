// ignore_for_file: prefer_const_literals_to_create_immutables, library_private_types_in_public_api, library_prefixes
import 'package:flutter/material.dart';
import 'package:sales_control/page/adicionar_cliente.dart';
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/external/obter_clientes.dart' as listaClientes;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FiadosScreen(),
    );
  }
}

class FiadosScreen extends StatefulWidget {
  const FiadosScreen({super.key});

  @override
  _FiadosScreenState createState() => _FiadosScreenState();
}

class _FiadosScreenState extends State<FiadosScreen> {
  late Future<List<Cliente>> clientesFuture;

  @override
  void initState() {
    super.initState();
    clientesFuture = listaClientes.ObterListaClientes().obterClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
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
                    // DataColumn(label: Text('Pagamento')),
                  ],
                  rows: clientes.map((cliente) {
                    return DataRow(cells: [
                      DataCell(Text(cliente.nome)),
                      DataCell(Text(cliente.endereco)),
                      DataCell(Text(cliente.telefone)),
                      // DataCell(Text(cliente.pagamento)),
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
