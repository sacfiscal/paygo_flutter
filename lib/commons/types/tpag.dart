enum Tpag {
  dinheiro,
  cheque,
  cartaoCredito,
  cartaoDebito,
  creditoLoja,
  valeAlimentacao,
  valeRefeicao,
  valePresente,
  valeCombustivel,
  boletoBancario,
  depositoBancario,
  pagamentoInstantaneo,
  transferenciaBancaria,
  programaFidelidade,
  semPagamento,
  outros,
}

extension TpagExtension on Tpag {
  String get display {
    switch (this) {
      case Tpag.dinheiro:
        return '01 - Dinheiro';
      case Tpag.cheque:
        return '02 -  Cheque';
      case Tpag.cartaoCredito:
        return '03 - Cartão de Crédito';
      case Tpag.cartaoDebito:
        return '04 - Cartão de Débito';
      case Tpag.creditoLoja:
        return '05 - Crédito Loja';
      case Tpag.valeAlimentacao:
        return '10 - Vale Alimentação';
      case Tpag.valeRefeicao:
        return '11 - Vale Refeição';
      case Tpag.valePresente:
        return '12 - Vale Presente';
      case Tpag.valeCombustivel:
        return '13 - Vale Combustível';
      case Tpag.boletoBancario:
        return '15 - Boleto Bancário';
      case Tpag.depositoBancario:
        return '16 - Depósito Bancário';
      case Tpag.pagamentoInstantaneo:
        return '17 - Pagamento Instantâneo (PIX)';
      case Tpag.transferenciaBancaria:
        return '18 - Transferência bancária, Carteira Digital';
      case Tpag.programaFidelidade:
        return '19 - Programa de fidelidade, Cashback, Crédito Virtual';
      case Tpag.semPagamento:
        return '90 - Sem pagamento';
      case Tpag.outros:
        return '99 - Outros';
      default:
        return '99 - Outros';
    }
  }

  String get value {
    switch (this) {
      case Tpag.dinheiro:
        return '01';
      case Tpag.cheque:
        return '02';
      case Tpag.cartaoCredito:
        return '03';
      case Tpag.cartaoDebito:
        return '04';
      case Tpag.creditoLoja:
        return '05';
      case Tpag.valeAlimentacao:
        return '10';
      case Tpag.valeRefeicao:
        return '11';
      case Tpag.valePresente:
        return '12';
      case Tpag.valeCombustivel:
        return '13';
      case Tpag.boletoBancario:
        return '15';
      case Tpag.depositoBancario:
        return '16';
      case Tpag.pagamentoInstantaneo:
        return '17';
      case Tpag.transferenciaBancaria:
        return '18';
      case Tpag.programaFidelidade:
        return '19';
      case Tpag.semPagamento:
        return '90';
      case Tpag.outros:
        return '99';
      default:
        return '99';
    }
  }
}

String obterTpagDisplay(String tpagValue) {
  switch (tpagValue) {
    case '01':
      return '01 - Dinheiro';
    case '02':
      return '02 -  Cheque';
    case '03':
      return '03 - Cartão de Crédito';
    case '04':
      return '04 - Cartão de Débito';
    case '05':
      return '05 - Crédito Loja';
    case '10':
      return '10 - Vale Alimentação';
    case '11':
      return '11 - Vale Refeição';
    case '12':
      return '12 - Vale Presente';
    case '13':
      return '13 - Vale Combustível';
    case '15':
      return '15 - Boleto Bancário';
    case '16':
      return '16 - Depósito Bancário';
    case '17':
      return '17 - Pagamento Instantâneo (PIX)';
    case '18':
      return '18 - Transferência bancária, Carteira Digital';
    case '19':
      return '19 - Programa de fidelidade, Cashback, Crédito Virtual';
    case '90':
      return '90 - Sem pagamento';
    case '99':
      return '99 - Outros';
    default:
      return '99 - Outros';
  }
}
