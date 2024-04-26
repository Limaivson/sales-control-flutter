// ignore_for_file: depend_on_referenced_packages, library_prefixes
import 'package:sales_control/adapter/clientes_adapter_fb.dart' as adapterClientes;
import 'package:sales_control/entities/cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sales_control/firebase_options.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    var obterClientes = ObterListaClientes();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await obterClientes.obterClientes();
  }

class ObterListaClientes{
  Future<List<Cliente>> obterClientes() async {
    CollectionReference vendas = FirebaseFirestore.instance.collection('vendas');
    QuerySnapshot querySnapshot = await vendas.get();
    if (querySnapshot.docs.isNotEmpty) {
      List<Cliente> clientes = adapterClientes.fbToCliente(querySnapshot);
      return clientes;
    } else {
      throw 'Erro ao obter os clientes';
    }
  }

  
  // Future<List<Cliente>> obterClientes() async {
  //   var response = await http.get(Uri.parse('$url/listar-clientes/'));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     List<Cliente> clientes = adapterClientes.jsonToCliente(json);
  //     return clientes;
  //   } else {
  //     throw 'Erro ao obter os clientes';
  //   }
  // }

  // Future<List<Cliente>> obterClientesRecebidos() async {
  //   var response = await http.get(Uri.parse('$url/listar-clientes-pagos/'));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> json = jsonDecode(response.body);
  //     List<Cliente> clientes = adapterClientes.jsonToClienteRecebidos(json);
  //     return clientes;
  //   } else {
  //     throw 'Erro ao obter os clientes';
  //   }
  // }
}