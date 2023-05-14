enum Status {
  ativo,
  inativo,
}

extension StatusExtension on Status {
  String get display {
    switch (this) {
      case Status.ativo:
        return 'Ativo';
      case Status.inativo:
        return 'Inativo';
    }
  }

  int get value {
    switch (this) {
      case Status.ativo:
        return 1;
      case Status.inativo:
        return 0;
    }
  }
}

String obterStatusDisplay(String ambienteValue) {
  switch (ambienteValue) {
    case '1':
      return 'Ativo';
    case '0':
      return 'Inativo';
    default:
      return 'Inativo';
  }
}
