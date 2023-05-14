enum Indiedest {
  contribuinteIcms,
  contribuinteIsento,
  naoContribuinte,
}

extension IndiedestExtension on Indiedest {
  String get display {
    switch (this) {
      case Indiedest.contribuinteIcms:
        return '1 - Contribuinte ICMS (informar a IE do destinatário)';
      case Indiedest.contribuinteIsento:
        return '2 - Contribuinte isento de Inscrição no cadastro de Contribuintes';
      case Indiedest.naoContribuinte:
        return '9 - Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.';
    }
  }

  int get value {
    switch (this) {
      case Indiedest.contribuinteIcms:
        return 1;
      case Indiedest.contribuinteIsento:
        return 2;
      case Indiedest.naoContribuinte:
        return 9;
    }
  }
}

String obterIndiedestDisplay(String value) {
  switch (value) {
    case '1':
      return '1 - Contribuinte ICMS (informar a IE do destinatário)';
    case '2':
      return '2 - Contribuinte isento de Inscrição no cadastro de Contribuintes';
    case '9':
      return '9 - Não Contribuinte, que pode ou não possuir Inscrição Estadual no Cadastro de Contribuintes do ICMS.';
    default:
      return '';
  }
}
