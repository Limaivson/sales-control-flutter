// ignore_for_file: prefer_initializing_formals

class Pagamento{
  late double valor;
  late String tipoPagamento;
  late String dataPagamento;
  late String dataRealizacaoPagamento;

  Pagamento({
    required valor,
    required tipoPagamento,
    required dataPagamento,
    required dataRealizacaoPagamento
    }){
    this.valor = valor;
    this.tipoPagamento = tipoPagamento;
    this.dataPagamento = dataPagamento;
    this.dataRealizacaoPagamento = dataRealizacaoPagamento;
    }
}