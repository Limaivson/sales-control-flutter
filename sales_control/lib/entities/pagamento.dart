class Pagamento{
  // final int idCliente;
  // final int idFuncionario;
  late String valor;
  late String tipoPagamento;
  late String data;

  Pagamento({
    required valor,
    required tipoPagamento, 
    required data}){
    this.valor = valor;
    this.tipoPagamento = tipoPagamento;
    this.data = data;
    }
}