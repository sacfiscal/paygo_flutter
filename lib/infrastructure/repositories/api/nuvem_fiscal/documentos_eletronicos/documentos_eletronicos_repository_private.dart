part of 'documentos_eletronicos_repository.dart';

abstract class IDocumentosEletronicosCnpjRepository {
  Future<CnpjListarEmpresaDto> consultarCnpj({
    required String cnpj,
  });
}

abstract class IDocumentosEletronicosRepositoryEmpresa {
  IDocumentosEletronicosRepositoryEmpresaCpfCnpj get cpfCnpj;

  Future<String> listarEmpresas({
    int? top,
    int? skip,
    bool? inlinecount,
    String? cnpjCpf,
  });
}

abstract class IDocumentosEletronicosRepositoryEmpresaCpfCnpj {
  IDocumentosEletronicosRepositoryEmpresaCpfCnpjNfce get nfce;

  Future<EmpresaDto> consultarEmpresa({
    required String cnpjCpf,
  });
}

abstract class IDocumentosEletronicosRepositoryEmpresaCpfCnpjNfce {
  Future<EmpresaConfiguracaoNfceDto> consultarConfiguracao({
    required String cnpjCpf,
  });

  Future<String> salvarConfiguracao({
    required String cnpjCpf,
    required EmpresaConfiguracaoNfceDto body,
  });
}

abstract class IDocumentosEletronicosRepositoryNfce {
  Future<String> listarNfce({
    int? top = 10,
    int? skip = 0,
    bool? inlinecount,
    required String? cnpjCpf,
    required String? ambiente,
  });

  Future<String> consultarStatusServico({
    required String cnpjCpf,
  });

  Future<RetornoAutorizacaoDto> emitirNfce({
    required NfcePedidoEmissaoDto body,
  });

  Future<String> consultarNfce({
    required String id,
  });

  Future<String> baixarXml({
    required String id,
  });

  Future<String> baixarPdf({
    required String id,
  });

  Future<String> baixarEscpos({
    required String id,
    int modelo,
    int colunas,
  });

  Future<RetornoCancelamentoDto> cancelarNfce({
    required String id,
    required String justificativa,
  });

  Future<String> consultarCancelamento({
    required String id,
  });

  Future<String> baixarXmlCancelamento({
    required String id,
  });

  Future<String> baixarPdfCancelamento({
    required String id,
  });

  Future<RetornoInutilizacaoDto> inutilizarSequencia({
    required String justificativa,
    required int numeroInicial,
    required int numeroFinal,
    required int serie,
    required int ano,
    required String cnpj,
    required String ambiente,
  });
}

class _DocumentosEletronicosCnpjRepository implements IDocumentosEletronicosCnpjRepository {
  @override
  Future<CnpjListarEmpresaDto> consultarCnpj({
    required String cnpj,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().cnpj(
      accept: 'application/json',
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cnpj: cnpj,
    );
    return CnpjListarEmpresaDto.fromJson(json.decode(resultado));
  }
}

class _DocumentosEletronicosRepositoryEmpresa implements IDocumentosEletronicosRepositoryEmpresa {
  final IDocumentosEletronicosRepositoryEmpresaCpfCnpj _cpfCnpj = _DocumentosEletronicosRepositoryEmpresaCpfCnpj();

  @override
  IDocumentosEletronicosRepositoryEmpresaCpfCnpj get cpfCnpj => _cpfCnpj;

  @override
  Future<String> listarEmpresas({
    int? top,
    int? skip,
    bool? inlinecount,
    String? cnpjCpf,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().empresaListarEmpresas(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      top: top,
      skip: skip,
      inlinecount: inlinecount,
      cnpjCpf: cnpjCpf,
    );

    Get.find<Logger>().i('\nListando as empresas cadastradas\n\n ${resultado.toString()}');

    return resultado;
  }
}

class _DocumentosEletronicosRepositoryEmpresaCpfCnpj implements IDocumentosEletronicosRepositoryEmpresaCpfCnpj {
  final _DocumentosEletronicosRepositoryEmpresaCpfCnpjNfce _nfce = _DocumentosEletronicosRepositoryEmpresaCpfCnpjNfce();

  @override
  IDocumentosEletronicosRepositoryEmpresaCpfCnpjNfce get nfce => _nfce;

  @override
  Future<EmpresaDto> consultarEmpresa({
    required String cnpjCpf,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().empresaCpfCnpjConsultarEmpresa(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cnpjCpf: cnpjCpf,
    );

    Get.find<Logger>().i('\nObtendo dados da empresa na API da Nuvem Fiscal\n\n ${resultado.toString()}');

    return EmpresaDto.fromJson(json.decode(resultado));
  }
}

class _DocumentosEletronicosRepositoryEmpresaCpfCnpjNfce implements IDocumentosEletronicosRepositoryEmpresaCpfCnpjNfce {
  @override
  Future<EmpresaConfiguracaoNfceDto> consultarConfiguracao({
    required String cnpjCpf,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().empresaCpfCnpjNfceConsultarConfiguracao(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cnpjCpf: cnpjCpf,
    );

    Get.find<Logger>().i('\nBuscando as configurações de emissão de NFCe da empresa\n\n ${resultado.toString()}');

    return EmpresaConfiguracaoNfceDto.fromJson(json.decode(resultado));
  }

  @override
  Future<String> salvarConfiguracao({
    required String cnpjCpf,
    required EmpresaConfiguracaoNfceDto body,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().empresaCpfCnpjNfceSalvarConfiguracao(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cnpjCpf: cnpjCpf,
      body: jsonEncode(body.toJson()),
    );

    Get.find<Logger>().i('\nAlterando as configurações de emissão de NFCe da empresa\n\n ${resultado.toString()}');

    return resultado;
  }
}

class _DocumentosEletronicosRepositoryNfce implements IDocumentosEletronicosRepositoryNfce {
  @override
  Future<String> listarNfce({
    int? top = 10,
    int? skip = 0,
    bool? inlinecount,
    required String? cnpjCpf,
    required String? ambiente,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceListarNotasFiscais(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      top: top,
      skip: skip,
      inlinecount: inlinecount,
      cnpjCpf: cnpjCpf,
      ambiente: ambiente,
    );

    Get.find<Logger>().i('\nListando as notas fiscais emitidas\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> consultarStatusServico({
    required String cnpjCpf,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceConsultarStatusSefaz(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cnpjCpf: cnpjCpf,
    );

    Get.find<Logger>().i('\nConsultando o status do serviço no SEFAZ\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<RetornoAutorizacaoDto> emitirNfce({
    required NfcePedidoEmissaoDto body,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceEmitirNotaFiscal(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      body: jsonEncode(body.toJson()),
    );

    Get.find<Logger>().i('\nEmitindo uma NFCe\n\n ${resultado.toString()}');

    return RetornoAutorizacaoDto.fromJson(json.decode(resultado));
  }

  @override
  Future<String> consultarNfce({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceConsultarNotaFiscal(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nConsultando uma NFCe na API da Nuvem Fiscal\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> baixarXml({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceBaixarXml(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nbaixando o XML da NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> baixarPdf({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceBaixarPdf(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nBaixando o PDF da NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> baixarEscpos({
    required String id,
    int modelo = 0,
    int colunas = 30,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceBaixarEscpos(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
      modelo: modelo,
      colunas: colunas,
    );

    Get.find<Logger>().i('\nBaixando o PDF da NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<RetornoCancelamentoDto> cancelarNfce({
    required String id,
    required String justificativa,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceCancelarNotaFiscal(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
      body: jsonEncode({'justificativa': justificativa}),
    );

    Get.find<Logger>().i('\nCancelando uma NFCe\n\n ${resultado.toString()}');

    return RetornoCancelamentoDto.fromJson(json.decode(resultado));
  }

  @override
  Future<String> consultarCancelamento({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceConsultarCancelamento(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nConsultando o cancelamento de uma NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> baixarXmlCancelamento({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceBaixarXmlCancelamento(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nBaixando o XML de cancelamento de uma NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<String> baixarPdfCancelamento({
    required String id,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceBaixarPdfCancelamento(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      id: id,
    );

    Get.find<Logger>().i('\nBaixando o PDF de cancelamento de uma NFCe\n\n ${resultado.toString()}');

    return resultado;
  }

  @override
  Future<RetornoInutilizacaoDto> inutilizarSequencia({
    required String justificativa,
    required int numeroInicial,
    required int numeroFinal,
    required int serie,
    required int ano,
    required String cnpj,
    required String ambiente,
  }) async {
    var resultado = await Get.find<DocumentosEletronicosService>().nfceInutilizarNumeracao(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      body: jsonEncode(
        {
          "justificativa": justificativa,
          "numero_inicial": numeroInicial,
          "numero_final": numeroFinal,
          "serie": serie,
          "ano": ano,
          "cnpj": cnpj,
          "ambiente": ambiente
        },
      ),
    );

    Get.find<Logger>().i('\nInutilizando uma sequencia de numeração\n\n ${resultado.toString()}');

    return RetornoInutilizacaoDto.fromJson(json.decode(resultado));
  }
}
