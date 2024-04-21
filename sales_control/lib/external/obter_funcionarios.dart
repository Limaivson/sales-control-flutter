// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'package:sales_control/adapter/funcionarios_adapter.dart';
import 'package:sales_control/entities/funcionario.dart';
import 'package:sales_control/external/url.dart';
import 'package:http/http.dart' as http;

class ObterFuncionarios {
  Future<List<Funcionario>> obterFuncionarios() async {
    var response = await http.get(Uri.parse('$url/listar-funcionarios/'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      List<Funcionario> funcionarios = jsonToFuncionario(json);
      return funcionarios;
    } else {
      throw 'Erro ao obter os funcionarios';
    }
  }
}