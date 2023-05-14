enum SituacaoNotaFiscal {
  pendente,
  autorizada,
  cancelada,
}

extension SituacaoNotaFiscalExtension on SituacaoNotaFiscal {
  String get display {
    switch (this) {
      case SituacaoNotaFiscal.pendente:
        return 'Pendente';
      case SituacaoNotaFiscal.autorizada:
        return 'Autorizada';
      case SituacaoNotaFiscal.cancelada:
        return 'Cancelada';
      default:
        return 'Pendente';
    }
  }

  int get value {
    switch (this) {
      case SituacaoNotaFiscal.pendente:
        return 1;
      case SituacaoNotaFiscal.autorizada:
        return 2;
      case SituacaoNotaFiscal.cancelada:
        return 3;
      default:
        return 1;
    }
  }
}

String obterSituacaoNotaFiscalDisplay(String situacaoNotaFiscalValue) {
  switch (situacaoNotaFiscalValue) {
    case '1':
      return 'Pendente';
    case '2':
      return 'Autorizada';
    case '3':
      return 'Cancelada';
    default:
      return 'Pendente';
  }
}

SituacaoNotaFiscal obterSituacaoNotaFiscal(String situacaoNotaFiscalValue) {
  switch (situacaoNotaFiscalValue) {
    case '1':
      return SituacaoNotaFiscal.pendente;
    case '2':
      return SituacaoNotaFiscal.autorizada;
    case '3':
      return SituacaoNotaFiscal.cancelada;
    default:
      return SituacaoNotaFiscal.pendente;
  }
}
