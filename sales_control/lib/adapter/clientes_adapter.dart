import 'package:sales_control/entities/cliente.dart';
import 'package:sales_control/entities/funcionario.dart';
import 'package:sales_control/entities/pagamento.dart';

List<Cliente> jsonToCliente(Map<String, dynamic> json) {
  List<Cliente> clientes = [];
  if (json.containsKey('clientes')) {
    List<dynamic> clientesJson = json['clientes'];
    for (Map clienteJson in clientesJson) {
      Cliente cliente = Cliente(
        id: clienteJson['id'],
        nome: clienteJson['nome'],
        telefone: clienteJson['telefone'],
        endereco: clienteJson['endereco'],
        pagamento: Pagamento(data: '', tipoPagamento: '', valor: ''),
        funcionario: Funcionario(nome: ''),
      );
      clientes.add(cliente);
    }
  }
  return clientes;
}

List<Cliente> jsonToClienteRecebidos(Map<String, dynamic> json) {
  List<Cliente> clientes = [];
  if (json.containsKey('clientes')) {
    List<dynamic> clientesJson = json['clientes'];
    for (Map clienteJson in clientesJson) {
      Funcionario func = Funcionario(
        nome: clienteJson['funcionario'],
      );
      Pagamento pag = Pagamento(
        valor: clienteJson['valor'],
        tipoPagamento: clienteJson['tipo_pagamento'],
        data: clienteJson['data'],
      );
      Cliente cliente = Cliente(
        id: clienteJson['id'],
        nome: clienteJson['nome'],
        telefone: clienteJson['telefone'],
        endereco: clienteJson['endereco'],
        pagamento: pag,
        funcionario: func,
      );
      clientes.add(cliente);
    }
  }
  return clientes;
}
