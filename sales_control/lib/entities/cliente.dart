import 'package:sales_control/entities/funcionario.dart';
import 'package:sales_control/entities/pagamento.dart';

class Cliente{
  final String id;
  final String nome;
  final String telefone;
  final String endereco;
  final String dataCompra;
  late Pagamento pagamento;
  late Funcionario funcionario;

  Cliente({
    required this.id, 
    required this.nome, 
    required this.telefone, 
    required this.endereco, 
    required this.dataCompra,
    required this.pagamento, 
    required this.funcionario
  });
}
