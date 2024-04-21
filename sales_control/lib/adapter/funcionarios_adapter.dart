import 'package:sales_control/entities/funcionario.dart';

List<Funcionario> jsonToFuncionario(Map<String, dynamic> json) {
  List<Funcionario> funcionarios = [];
  if (json.containsKey('funcionarios')) {
    List<dynamic> funcionariosJson = json['funcionarios'];
    for (Map funcionarioJson in funcionariosJson) {
      Funcionario funcionario = Funcionario(
        nome: funcionarioJson['nome'],
      );
      funcionarios.add(funcionario);
    }
  }
  return funcionarios;
}
