// ignore_for_file: depend_on_referenced_packages
import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/entities/funcionario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/entities/pagamento.dart';

List<Cliente> fbToClienteFiados(QuerySnapshot snap, bool fiado) {
  List<Cliente> clientesFiados = [];
  List<Cliente> clientesRecebidos = [];
  for (QueryDocumentSnapshot clienteFb in snap.docs) {
    Map<String, dynamic> dados = clienteFb.data() as Map<String, dynamic>;
    String nomeFunc = nomeFuncionario(dados['nomeFuncionario']);
    bool pago = dados['pago'];
    
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
        pago: dados['pago'] ?? false,
      ),
      funcionario: Funcionario(nome: nomeFunc),
    );
    if(pago==false){
      clientesFiados.add(cliente);
    }
    else{
      clientesRecebidos.add(cliente);
    }
  }
  if(fiado){
    return clientesFiados;
  }
  else{
    return clientesRecebidos;
  }
}

String nomeFuncionario(String nomeFuncionario) {
  if(nomeFuncionario == 'p@gmail.com'){
    nomeFuncionario = 'Pedro';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'je@gmail.com'){
    nomeFuncionario = 'José Eudes';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'rss@gmail.com'){
    nomeFuncionario = 'Rafael';
    return nomeFuncionario;
  } else if(nomeFuncionario == 's@gmail.com'){
    nomeFuncionario = 'Suemo';
    return nomeFuncionario;
  } else if(nomeFuncionario == 'mj@gmail.com'){
    nomeFuncionario = 'Marcos José';
    return nomeFuncionario;
  }
  return 'Funcionário não encontrado';
}
