enum OrigemMercadoria {
  nacional,
  estrangeiraImportacaoDireta,
  estrangeiraAdquiridaMercadoInterno,
  nacionalConteudoImportacaoSuperior40,
  nacionalProducaoProcessosProdutivosBasicos,
  nacionalConteudoImportacaoInferior40,
  estrangeiraImportacaoDiretaSemSimilarNacional,
  estrangeiraAdquiridaMercadoInternoSemSimilarNacional,
  nacionalConteudoImportacaoSuperior70,
}

extension OrigemMercadoriaExtension on OrigemMercadoria {
  String get origemMercadoriaString {
    switch (this) {
      case OrigemMercadoria.nacional:
        return '0 - Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8';
      case OrigemMercadoria.estrangeiraImportacaoDireta:
        return '1 - Estrangeira - Importação direta, exceto a indicada no código 6';
      case OrigemMercadoria.estrangeiraAdquiridaMercadoInterno:
        return '2 - Estrangeira - Adquirida no mercado interno, exceto a indicada no código 7';
      case OrigemMercadoria.nacionalConteudoImportacaoSuperior40:
        return '3 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 40% e inferior ou igual a 70%';
      case OrigemMercadoria.nacionalProducaoProcessosProdutivosBasicos:
        return '4 - Nacional, cuja produção tenha sido feita em conformidade com os processos produtivos básicos de que tratam as legislações citadas nos Ajustes';
      case OrigemMercadoria.nacionalConteudoImportacaoInferior40:
        return '5 - Nacional, mercadoria ou bem com Conteúdo de Importação inferior ou igual a 40%';
      case OrigemMercadoria.estrangeiraImportacaoDiretaSemSimilarNacional:
        return '6 - Estrangeira - Importação direta, sem similar nacional, constante em lista da CAMEX e gás natural';
      case OrigemMercadoria.estrangeiraAdquiridaMercadoInternoSemSimilarNacional:
        return '7 - Estrangeira - Adquirida no mercado interno, sem similar nacional, constante lista CAMEX e gás natural';
      case OrigemMercadoria.nacionalConteudoImportacaoSuperior70:
        return '8 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 70%';
    }
  }

  int get origemMercadoriaInt {
    switch (this) {
      case OrigemMercadoria.nacional:
        return 0;
      case OrigemMercadoria.estrangeiraImportacaoDireta:
        return 1;
      case OrigemMercadoria.estrangeiraAdquiridaMercadoInterno:
        return 2;
      case OrigemMercadoria.nacionalConteudoImportacaoSuperior40:
        return 3;
      case OrigemMercadoria.nacionalProducaoProcessosProdutivosBasicos:
        return 4;
      case OrigemMercadoria.nacionalConteudoImportacaoInferior40:
        return 5;
      case OrigemMercadoria.estrangeiraImportacaoDiretaSemSimilarNacional:
        return 6;
      case OrigemMercadoria.estrangeiraAdquiridaMercadoInternoSemSimilarNacional:
        return 7;
      case OrigemMercadoria.nacionalConteudoImportacaoSuperior70:
        return 8;
    }
  }
}

String obterOrigemDisplay(String origem) {
  switch (origem) {
    case '0':
      return '0 - Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8';
    case '1':
      return '1 - Estrangeira - Importação direta, exceto a indicada no código 6';
    case '2':
      return '2 - Estrangeira - Adquirida no mercado interno, exceto a indicada no código 7';
    case '3':
      return '3 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 40% e inferior ou igual a 70%';
    case '4':
      return '4 - Nacional, cuja produção tenha sido feita em conformidade com os processos produtivos básicos de que tratam as legislações citadas nos Ajustes';
    case '5':
      return '5 - Nacional, mercadoria ou bem com Conteúdo de Importação inferior ou igual a 40%';
    case '6':
      return '6 - Estrangeira - Importação direta, sem similar nacional, constante em lista da CAMEX e gás natural';
    case '7':
      return '7 - Estrangeira - Adquirida no mercado interno, sem similar nacional, constante lista CAMEX e gás natural';
    case '8':
      return '9 - Nacional, mercadoria ou bem com Conteúdo de Importação superior a 70%';
    default:
      return '0 - Nacional, exceto as indicadas nos códigos 3, 4, 5 e 8';
  }
}
