// ignore_for_file: library_private_types_in_public_api, unused_field, depend_on_referenced_packages, unused_local_variable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_control/page/menu_principal.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _checkAuthStatus(),
    );
  }
}

Widget _checkAuthStatus(){
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    print('Usuário autenticado: ${user.email}');
    return const Menu();
  } else {
    print('Usuário não autenticado');
    return LoginPage();
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
            child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 250,
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: 250,
            child: TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              _signInWithEmailAndPassword();
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Autenticar usuário com e-mail e senha
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Usuário autenticado com sucesso
      User? user = userCredential.user;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Menu(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: Text('$e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
