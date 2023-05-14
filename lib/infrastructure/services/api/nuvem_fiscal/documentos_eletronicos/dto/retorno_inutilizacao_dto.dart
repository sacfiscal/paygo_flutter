// ignore_for_file: public_member_api_docs, sort_constructors_first

class RetornoInutilizacaoDto {
  String? id;
  String? ambiente;
  String? status;
  Autor? autor;
  String? dataEvento;
  int? numeroSequencial;
  String? dataRecebimento;
  int? codigoStatus;
  String? motivoStatus;
  String? numeroProtocolo;
  String? tipoEvento;
  String? cnpj;
  int? ano;
  int? modelo;
  int? serie;
  int? numeroInicial;
  int? numeroFinal;
  String? justificativa;

  RetornoInutilizacaoDto({
    this.id,
    this.ambiente,
    this.status,
    this.autor,
    this.dataEvento,
    this.numeroSequencial,
    this.dataRecebimento,
    this.codigoStatus,
    this.motivoStatus,
    this.numeroProtocolo,
    this.tipoEvento,
    this.cnpj,
    this.ano,
    this.modelo,
    this.serie,
    this.numeroInicial,
    this.numeroFinal,
    this.justificativa,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ambiente': ambiente,
      'status': status,
      'autor': autor?.toJson(),
      'data_evento': dataEvento,
      'numero_sequencial': numeroSequencial,
      'data_recebimento': dataRecebimento,
      'codigo_status': codigoStatus,
      'motivo_status': motivoStatus,
      'numero_protocolo': numeroProtocolo,
      'tipo_evento': tipoEvento,
      'cnpj': cnpj,
      'ano': ano,
      'modelo': modelo,
      'serie': serie,
      'numero_inicial': numeroInicial,
      'numero_final': numeroFinal,
      'justificativa': justificativa,
    };
  }

  factory RetornoInutilizacaoDto.fromJson(Map<String, dynamic> map) {
    return RetornoInutilizacaoDto(
      id: map['id'] != null ? map['id'] as String : null,
      ambiente: map['ambiente'] != null ? map['ambiente'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      autor: map['autor'] != null ? Autor.fromJson(map['autor'] as Map<String, dynamic>) : null,
      dataEvento: map['data_evento'] != null ? (map['data_evento']) : null,
      numeroSequencial: map['numero_sequencial'] != null ? map['numero_sequencial'] as int : null,
      dataRecebimento: map['data_recebimento'] != null ? (map['data_recebimento']) : null,
      codigoStatus: map['codigo_status'] != null ? map['codigo_status'] as int : null,
      motivoStatus: map['motivo_status'] != null ? map['motivo_status'] as String : null,
      numeroProtocolo: map['numero_protocolo'] != null ? map['numero_protocolo'] as String : null,
      tipoEvento: map['tipo_evento'] != null ? map['tipo_evento'] as String : null,
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      ano: map['ano'] != null ? map['ano'] as int : null,
      modelo: map['modelo'] != null ? map['modelo'] as int : null,
      serie: map['serie'] != null ? map['serie'] as int : null,
      numeroInicial: map['numero_inicial'] != null ? map['numero_inicial'] as int : null,
      numeroFinal: map['numero_final'] != null ? map['numero_final'] as int : null,
      justificativa: map['justificativa'] != null ? map['justificativa'] as String : null,
    );
  }
}

class Autor {
  String? cpfCnpj;

  Autor({
    this.cpfCnpj,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cpf_cnpj': cpfCnpj,
    };
  }

  factory Autor.fromJson(Map<String, dynamic> map) {
    return Autor(
      cpfCnpj: map['cpf_cnpj'] != null ? map['cpf_cnpj'] as String : null,
    );
  }
}
