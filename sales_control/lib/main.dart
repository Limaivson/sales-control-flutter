import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FiadosScreen()),
                );
              },
              child: const Text('Fiados'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecebidoScreen()),
                );
              },
              child: const Text('Recebido'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditarScreen()),
                );
              },
              child: const Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}

class FiadosScreen extends StatelessWidget {
  const FiadosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Fiados'),
      ),
      body: const Center(
        child: Text('Conteúdo da Tela de Fiados'),
      ),
    );
  }
}

class RecebidoScreen extends StatelessWidget {
  const RecebidoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Recebido'),
      ),
      body: const Center(
        child: Text('Conteúdo da Tela de Recebido'),
      ),
    );
  }
}

class EditarScreen extends StatelessWidget {
  const EditarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de Editar'),
      ),
      body: const Center(
        child: Text('Conteúdo da Tela de Editar'),
      ),
    );
  }
}
