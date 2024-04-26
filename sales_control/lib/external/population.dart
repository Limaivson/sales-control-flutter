// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  // Inicialize o Firebase
    WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Popula o banco de dados com vendas fictícias
  await popularVendas();
}

Future<void> popularVendas() async {
  // Referência para a coleção "vendas"
  // var db = FirebaseFirestore.instance;
  // db.collection('vendas').get().then((QuerySnapshot querySnapshot) {
  //   querySnapshot.docs.forEach((doc) {
  //     print(doc['nomeCliente']);
  //   });
  // });
  CollectionReference vendas = FirebaseFirestore.instance.collection('vendas');

  // Dados de exemplo das vendas
  List<Map<String, dynamic>> dadosVendas = [
    {
      'nomeCliente': 'Maria Oliveira',
      'endereco': 'Avenida B, 456',
      'dataCompra': DateTime.now().subtract(const Duration(days: 2)),
      'valor': 105.0,
      'nomeFuncionario': 'João',
      'dataPagamento': DateTime.now().subtract(const Duration(days: 1)), // Campo opcional
    },
    {
      'nomeCliente': 'João da Silva',
      'endereco': 'Rua A, 123',
      'dataCompra': DateTime.now().subtract(const Duration(days: 5)),
      'valor': 100.0,
      'nomeFuncionario': 'Maria',
      'dataPagamento': null, // Campo opcional
    },
    {
      'nomeCliente': 'Ana Santos',
      'endereco': 'Rua C, 789',
      'dataCompra': DateTime.now().subtract(const Duration(days: 10)),
      'valor': 100.0,
      'nomeFuncionario': 'Carlos',
      'dataPagamento': DateTime.now(), // Campo opcional
    },
    {
      'nomeCliente': 'Pedro Almeida',
      'endereco': 'Avenida D, 1011',
      'dataCompra': DateTime.now().subtract(const Duration(days: 7)),
      'valor': 110.0,
      'nomeFuncionario': 'Mariana',
      'dataPagamento': null, // Campo opcional
    },
    {
      'nomeCliente': 'Carla Mendes',
      'endereco': 'Rua E, 1315',
      'dataCompra': DateTime.now().subtract(const Duration(days: 3)),
      'valor': 100.0,
      'nomeFuncionario': 'Paulo',
      'dataPagamento': null, // Campo opcional
    },
    {
      'nomeCliente': 'Antonio Ferreira',
      'endereco': 'Avenida F, 1617',
      'dataCompra': DateTime.now().subtract(const Duration(days: 8)),
      'valor': 105.0,
      'nomeFuncionario': 'Fernanda',
      'dataPagamento': DateTime.now(), // Campo opcional
    },
    {
      'nomeCliente': 'Fernanda Lima',
      'endereco': 'Rua G, 1920',
      'dataCompra': DateTime.now().subtract(const Duration(days: 6)),
      'valor': 95.0,
      'nomeFuncionario': 'Antonio',
      'dataPagamento': null, // Campo opcional
    },
    {
      'nomeCliente': 'Lucas Souza',
      'endereco': 'Avenida H, 2122',
      'dataCompra': DateTime.now().subtract(const Duration(days: 4)),
      'valor': 90.0,
      'nomeFuncionario': 'Juliana',
      'dataPagamento': DateTime.now(), // Campo opcional
    },
    {
      'nomeCliente': 'Mariana Oliveira',
      'endereco': 'Rua I, 2324',
      'dataCompra': DateTime.now().subtract(const Duration(days: 9)),
      'valor': 110.0,
      'nomeFuncionario': 'Rafael',
      'dataPagamento': null, // Campo opcional
    },
    {
      'nomeCliente': 'Paulo Santos',
      'endereco': 'Avenida J, 2526',
      'dataCompra': DateTime.now().subtract(const Duration(days: 1)),
      'valor': 105.0,
      'nomeFuncionario': 'Camila',
      'dataPagamento': null, // Campo opcional
    },
  ];

  // Adicionar cada venda ao Firestore
  for (var dadosVenda in dadosVendas) {
    await vendas.add(dadosVenda);
  }

  print('Vendas adicionadas com sucesso ao Firestore!');
}
