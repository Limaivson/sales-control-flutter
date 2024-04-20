// ignore_for_file: depend_on_referenced_packages, library_prefixes
import 'dart:convert';
import 'package:sales_control/adapter/clientes_adapter.dart' as adapterClientes;
import 'package:sales_control/entities/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:sales_control/external/url.dart';

class ObterListaClientes{

  Future<List<Cliente>> obterClientes() async {
    var response = await http.get(Uri.parse('$url/listar-clientes/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Cliente> clientes = adapterClientes.jsonToCliente(json);
      return clientes;
    } else {
      throw 'Erro ao obter os clientes';
    }
  }

  Future<List<Cliente>> obterClientesRecebidos() async {
    var response = await http.get(Uri.parse('$url/listar-clientes-pagos/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Cliente> clientes = adapterClientes.jsonToClienteRecebidos(json);
      return clientes;
    } else {
      throw 'Erro ao obter os clientes';
    }
  }
}