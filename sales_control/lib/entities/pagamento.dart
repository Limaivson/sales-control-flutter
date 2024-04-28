// ignore_for_file: prefer_initializing_formals

class Pagamento{
  late String valor;
  late String tipoPagamento;
  late String dataPagamento;
  late String dataRealizacaoPagamento;
  late bool pago;

  Pagamento({
    required this.valor,
    required this.tipoPagamento,
    required this.dataPagamento,
    required this.dataRealizacaoPagamento,
    required this.pago
    });
}