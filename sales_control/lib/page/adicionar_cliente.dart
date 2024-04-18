import 'package:flutter/material.dart';
import 'package:sales_control/fiados.dart';

class AdicionarClienteScreen extends StatefulWidget {
  final Function(Fiado) onAddClient;

  const AdicionarClienteScreen({super.key, required this.onAddClient});

  @override
  // ignore: library_private_types_in_public_api
  _AdicionarClienteScreenState createState() => _AdicionarClienteScreenState();
}

class _AdicionarClienteScreenState extends State<AdicionarClienteScreen> {
  late String cliente = '';
  late String endereco = '';
  late String funcionario = '';
  late String pagamento = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome do Cliente'),
              onChanged: (value) {
                setState(() {
                  cliente = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Endereço'),
              onChanged: (value) {
                setState(() {
                  endereco = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Nome do Funcionário'),
              onChanged: (value) {
                setState(() {
                  funcionario = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Pagamento'),
              onChanged: (value) {
                setState(() {
                  pagamento = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (cliente.isNotEmpty && endereco.isNotEmpty && funcionario.isNotEmpty && pagamento.isNotEmpty) {
                  widget.onAddClient(Fiado(cliente: cliente, endereco: endereco, funcionario: funcionario, pagamento: pagamento));
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
