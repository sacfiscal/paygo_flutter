// ignore_for_file: public_member_api_docs, sort_constructors_first

class RetornoCancelamentoDto {
  String? id;
  String? ambiente;
  String? status;
  Autor? autor;
  String? chaveAcesso;
  String? dataEvento;
  int? numeroSequencial;
  String? dataRecebimento;
  int? codigoStatus;
  String? motivoStatus;
  String? numeroProtocolo;
  String? tipoEvento;
  String? justificativa;

  RetornoCancelamentoDto({
    this.id,
    this.ambiente,
    this.status,
    this.autor,
    this.chaveAcesso,
    this.dataEvento,
    this.numeroSequencial,
    this.dataRecebimento,
    this.codigoStatus,
    this.motivoStatus,
    this.numeroProtocolo,
    this.tipoEvento,
    this.justificativa,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ambiente': ambiente,
      'status': status,
      'autor': autor?.toJson(),
      'chave_acesso': chaveAcesso,
      'data_evento': dataEvento,
      'numero_sequencial': numeroSequencial,
      'data_recebimento': dataRecebimento,
      'codigo_status': codigoStatus,
      'motivo_status': motivoStatus,
      'numero_protocolo': numeroProtocolo,
      'tipo_evento': tipoEvento,
      'justificativa': justificativa,
    };
  }

  factory RetornoCancelamentoDto.fromJson(Map<String, dynamic> map) {
    return RetornoCancelamentoDto(
      id: map['id'] != null ? map['id'] as String : null,
      ambiente: map['ambiente'] != null ? map['ambiente'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      autor: map['autor'] != null ? Autor.fromJson(map['autor'] as Map<String, dynamic>) : null,
      chaveAcesso: map['chave_acesso'] != null ? map['chave_acesso'] as String : null,
      dataEvento: map['data_evento'] != null ? (map['data_evento']) : null,
      numeroSequencial: map['numero_sequencial'] != null ? map['numero_sequencial'] as int : null,
      dataRecebimento: map['data_recebimento'] != null ? (map['data_recebimento']) : null,
      codigoStatus: map['codigo_status'] != null ? map['codigo_status'] as int : null,
      motivoStatus: map['motivo_status'] != null ? map['motivo_status'] as String : null,
      numeroProtocolo: map['numero_protocolo'] != null ? map['numero_protocolo'] as String : null,
      tipoEvento: map['tipoEvento'] != null ? map['tipoEvento'] as String : null,
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
      'cpfCnpj': cpfCnpj,
    };
  }

  factory Autor.fromJson(Map<String, dynamic> map) {
    return Autor(
      cpfCnpj: map['cpfCnpj'] != null ? map['cpfCnpj'] as String : null,
    );
  }
}
