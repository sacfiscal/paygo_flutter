// ignore_for_file: public_member_api_docs, sort_constructors_first

class RetornoAutorizacaoDto {
  String? id;
  String? ambiente;
  String? createdAt;
  String? status;
  String? dataEmissao;
  int? serie;
  int? numero;
  double? valorTotal;
  String? chave;
  Autorizacao? autorizacao;

  RetornoAutorizacaoDto({
    this.id,
    this.ambiente,
    this.createdAt,
    this.status,
    this.dataEmissao,
    this.serie,
    this.numero,
    this.valorTotal,
    this.chave,
    this.autorizacao,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'ambiente': ambiente,
      'created_at': createdAt,
      'status': status,
      'data_emissao': dataEmissao,
      'serie': serie,
      'numero': numero,
      'valor_total': valorTotal,
      'chave': chave,
      'autorizacao': autorizacao?.toJson(),
    };
  }

  factory RetornoAutorizacaoDto.fromJson(Map<String, dynamic> map) {
    return RetornoAutorizacaoDto(
      id: map['id'] != null ? map['id'] as String : null,
      ambiente: map['ambiente'] != null ? map['ambiente'] as String : null,
      createdAt: map['created_at'] != null ? (map['created_at']) : null,
      status: map['status'] != null ? map['status'] as String : null,
      dataEmissao: map['data_emissao'] != null ? (map['data_emissao']) : null,
      serie: map['serie'] != null ? map['serie'] as int : null,
      numero: map['numero'] != null ? map['numero'] as int : null,
      valorTotal: map['valor_total'] != null ? double.tryParse(map['valor_total'].toString()) as double : null,
      chave: map['chave'] != null ? map['chave'] as String : null,
      autorizacao: map['autorizacao'] != null ? Autorizacao.fromJson(map['autorizacao'] as Map<String, dynamic>) : null,
    );
  }
}

class Autorizacao {
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
  String? digestValue;

  Autorizacao({
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
    this.digestValue,
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
      'digest_value': digestValue,
    };
  }

  factory Autorizacao.fromJson(Map<String, dynamic> map) {
    return Autorizacao(
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
      tipoEvento: map['tipo_evento'] != null ? map['tipo_evento'] as String : null,
      digestValue: map['digest_value'] != null ? map['digest_value'] as String : null,
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
