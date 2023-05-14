enum Ambiente {
  producao,
  homologacao,
}

extension AmbienteExtension on Ambiente {
  String get display {
    switch (this) {
      case Ambiente.homologacao:
        return 'Homologacao';
      case Ambiente.producao:
        return 'Producao';
      default:
        return 'Homologacao';
    }
  }

  int get value {
    switch (this) {
      case Ambiente.homologacao:
        return 2;
      case Ambiente.producao:
        return 1;
      default:
        return 2;
    }
  }
}

String obterAmbienteDisplay(String ambienteValue) {
  switch (ambienteValue) {
    case '1':
      return 'producao';
    case '2':
      return 'homologacao';
    default:
      return 'homologacao';
  }
}

Ambiente obterAmbienteFromDisplay(String ambienteValue) {
  switch (ambienteValue) {
    case 'producao':
      return Ambiente.producao;
    case 'homologacao':
      return Ambiente.homologacao;
    default:
      return Ambiente.homologacao;
  }
}

Ambiente obterAmbienteFromCode(String ambienteValue) {
  switch (ambienteValue) {
    case '1':
      return Ambiente.producao;
    case '2':
      return Ambiente.homologacao;
    default:
      return Ambiente.homologacao;
  }
}
