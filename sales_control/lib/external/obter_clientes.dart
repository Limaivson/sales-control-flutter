// ignore_for_file: depend_on_referenced_packages, library_prefixes
import 'package:sales_control/adapter/clientes_adapter_fb.dart' as adapterClientes;
import 'package:sales_control/entities/cliente.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ObterListaClientes{
  Future<List<Cliente>> obterClientes(bool fiado) async {
    CollectionReference vendas = FirebaseFirestore.instance.collection('vendas');
    QuerySnapshot querySnapshot = await vendas.get();
    if (querySnapshot.docs.isNotEmpty) {
      List<Cliente> clientes = adapterClientes.fbToCliente(querySnapshot, fiado);
      return clientes;
    } else {
      throw 'Erro ao obter os clientes';
    }
  }
}
