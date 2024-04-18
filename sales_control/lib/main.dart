import 'package:flutter/material.dart';
import 'package:sales_control/page/pageFiados.dart';
import 'package:sales_control/page/pageRecebidos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(icon: Icons.money, text: 'Fiados', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FiadosScreen()),
              );
            }),
            const SizedBox(width: 20),
            CustomButton(icon: Icons.attach_money, text: 'Recebido', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecebidosScreen()),
              );
            }),
            const SizedBox(width: 20),
            CustomButton(icon: Icons.edit, text: 'Editar', onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditarScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPressed;

  const CustomButton({super.key, required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(20, 20), // Defina o tamanho mínimo aqui
        maximumSize: const Size(100, 80), // Defina o tamanho máximo aqui
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 5),
          Text(text),
        ],
      ),
    );
  }
}

// class FiadosScreen extends StatelessWidget {
//   const FiadosScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tela de Fiados'),
//       ),
//       body: const Center(
//         child: Text('Conteúdo da Tela de Fiados'),
//       ),
//     );
//   }
// }

// class RecebidoScreen extends StatelessWidget {
//   const RecebidoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tela de Recebido'),
//       ),
//       body: const Center(
//         child: Text('Conteúdo da Tela de Recebido'),
//       ),
//     );
//   }
// }

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
