extension ImprimirXmlNFCeParamExtension on ImprimirXmlNFCeParam {
  int get value {
    switch (this) {
      case ImprimirXmlNFCeParam.param0001:
        return 0;
      case ImprimirXmlNFCeParam.param0002:
        return 2;
      case ImprimirXmlNFCeParam.param0004:
        return 4;
      case ImprimirXmlNFCeParam.param0008:
        return 8;
      case ImprimirXmlNFCeParam.param0016:
        return 16;
      case ImprimirXmlNFCeParam.param0032:
        return 32;
      case ImprimirXmlNFCeParam.param0064:
        return 64;
      case ImprimirXmlNFCeParam.param0128:
        return 128;
      case ImprimirXmlNFCeParam.param0256:
        return 256;
      case ImprimirXmlNFCeParam.param0512:
        return 512;
      case ImprimirXmlNFCeParam.param1024:
        return 1024;
      default:
        return 0;
    }
  }

  String get name {
    switch (this) {
      case ImprimirXmlNFCeParam.param0001:
        return 'Impressão de extrato resumido';
      case ImprimirXmlNFCeParam.param0002:
        return 'Utilização do EAN 13 no código dos produtos';
      case ImprimirXmlNFCeParam.param0004:
        return 'Impressão completa da descrição dos produtos';
      case ImprimirXmlNFCeParam.param0008:
        return 'Impressão do logotipo da empresa carregado em memória';
      case ImprimirXmlNFCeParam.param0016:
        return 'Impressão do cupom de homologação';
      case ImprimirXmlNFCeParam.param0032:
        return 'Redução do espaço de impressão do cupom';
      case ImprimirXmlNFCeParam.param0064:
        return 'Utilização de separadores de sessão para o cupom';
      case ImprimirXmlNFCeParam.param0128:
        return 'Impressão do IE no cabeçalho do cupom';
      case ImprimirXmlNFCeParam.param0256:
        return 'Impressão do número sequencial para cada item';
      case ImprimirXmlNFCeParam.param0512:
        return 'Impressão em uma via para Danfe em contingência';
      case ImprimirXmlNFCeParam.param1024:
        return 'Impressão de acréscimos/descontos por item';
      default:
        return 'Cupom Padrão';
    }
  }
}

enum ImprimirXmlNFCeParam {
  param0001,
  param0002,
  param0004,
  param0008,
  param0016,
  param0032,
  param0064,
  param0128,
  param0256,
  param0512,
  param1024
}
