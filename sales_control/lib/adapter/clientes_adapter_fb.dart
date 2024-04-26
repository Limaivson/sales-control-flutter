// ignore_for_file: depend_on_referenced_packages
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/entities/funcionario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/entities/pagamento.dart';

List<Cliente> fbToCliente(QuerySnapshot snap) {
  List<Cliente> clientes = [];
  for (QueryDocumentSnapshot clienteFb in snap.docs) {
    Map<String, dynamic> dados = clienteFb.data() as Map<String, dynamic>;
    Cliente cliente = Cliente(
      id: clienteFb.id,
      nome: dados['nomeCliente'] ?? "",
      telefone: dados['telefone'] ?? "",
      endereco: dados['endereco'] ?? "",
      dataCompra: dados['dataCompra'] != null ?
      '${dados['dataCompra'].toDate().day}/${dados['dataCompra'].toDate().month}/${dados['dataCompra'].toDate().year}' : "",
      pagamento: Pagamento(
        dataPagamento: dados['dataPagamento'] != null ?
            '${dados['dataPagamento'].toDate().day}/${dados['dataPagamento'].toDate().month}/${dados['dataPagamento'].toDate().year}' : '',
        valor: dados['valor'] ?? "",
        dataRealizacaoPagamento: dados['dataRealizacaoPagamento'] != null ?
            '${dados['dataRealizacaoPagamento'].toDate().day}/${dados['dataRealizacaoPagamento'].toDate().month}/${dados['dataRealizacaoPagamento'].toDate().year}' : '',
        tipoPagamento: dados['tipoPagamento'] ?? "",
      ),
      funcionario: Funcionario(nome: dados['nomeFuncionario'] ?? ""),
    );
    clientes.add(cliente);
  }
  return clientes;
}
