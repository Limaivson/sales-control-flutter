// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/entities/cliente.dart';

class ObterClientesFB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Cliente>> obterClientes() async {
    List<Cliente> clientes = [];
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('clientes').get();
      querySnapshot.docs.forEach((element) {
        // clientes.add(Cliente.fromMap(element.data()));
      });
    } catch (e) {
      print(e);
    }
    return clientes;
  }
}