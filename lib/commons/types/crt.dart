enum Crt {
  simplesNacional,
  simplesNacionalExcessoSublimite,
  regimeNormal,
}

extension CrtExtension on Crt {
  String get display {
    switch (this) {
      case Crt.simplesNacional:
        return '1 - Simples Nacional';
      case Crt.simplesNacionalExcessoSublimite:
        return '2 - Simples Nacional, excesso sublimite de receita bruta';
      case Crt.regimeNormal:
        return '3 - Regime Normal';
    }
  }

  int get value {
    switch (this) {
      case Crt.simplesNacional:
        return 1;
      case Crt.simplesNacionalExcessoSublimite:
        return 2;
      case Crt.regimeNormal:
        return 3;
    }
  }
}

String obterCrtDisplay(String value) {
  switch (value) {
    case '1':
      return '1 - Simples Nacional';
    case '2':
      return '2 - Simples Nacional, excesso sublimite de receita bruta';
    case '3':
      return '3 - Regime Normal';
    default:
      return '';
  }
}
