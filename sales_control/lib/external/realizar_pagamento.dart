import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class RealizarPagamento {

  Future<void> pagar(String idCliente, String valor, BuildContext context, bool pago) async {
    try{
      DocumentReference cliente = FirebaseFirestore.instance.collection('vendas').doc(idCliente);
      
      await cliente.update({
        'pago': pago,
        'dataRealizacaoPagamento': DateTime.now(),
        'valor': valor,
      });
      print('Pagando cliente: $idCliente');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pagamento realizado com sucesso'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao realizar o pagamento'),
          backgroundColor: Colors.red,
        ),
      );
      throw 'Erro ao realizar o pagamento';
    }
  }
// }