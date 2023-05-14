// ignore_for_file: public_member_api_docs, sort_constructors_first

class CnpjListarEmpresaDto {
  String? cnpj;
  String? razaoSocial;
  String? nomeFantasia;
  String? dataInicioAtividade;
  bool? matriz;
  AtividadePrincipal? naturezaJuridica;
  AtividadePrincipal? porte;
  SituacaoCadastral? situacaoCadastral;
  AtividadePrincipal? motivoSituacaoCadastral;
  AtividadePrincipal? atividadePrincipal;
  List<AtividadePrincipal>? atividadesSecundarias;
  Endereco? endereco;
  List<Telefone>? telefones;
  String? email;

  CnpjListarEmpresaDto({
    this.cnpj,
    this.razaoSocial,
    this.nomeFantasia,
    this.dataInicioAtividade,
    this.matriz,
    this.naturezaJuridica,
    this.porte,
    this.situacaoCadastral,
    this.motivoSituacaoCadastral,
    this.atividadePrincipal,
    this.atividadesSecundarias,
    this.endereco,
    this.telefones,
    this.email,
  });

  CnpjListarEmpresaDto copyWith({
    String? cnpj,
    String? razaoSocial,
    String? nomeFantasia,
    String? dataInicioAtividade,
    bool? matriz,
    AtividadePrincipal? naturezaJuridica,
    AtividadePrincipal? porte,
    SituacaoCadastral? situacaoCadastral,
    AtividadePrincipal? motivoSituacaoCadastral,
    AtividadePrincipal? atividadePrincipal,
    List<AtividadePrincipal>? atividadesSecundarias,
    Endereco? endereco,
    List<Telefone>? telefones,
    String? email,
  }) {
    return CnpjListarEmpresaDto(
      cnpj: cnpj ?? this.cnpj,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      dataInicioAtividade: dataInicioAtividade ?? this.dataInicioAtividade,
      matriz: matriz ?? this.matriz,
      naturezaJuridica: naturezaJuridica ?? this.naturezaJuridica,
      porte: porte ?? this.porte,
      situacaoCadastral: situacaoCadastral ?? this.situacaoCadastral,
      motivoSituacaoCadastral: motivoSituacaoCadastral ?? this.motivoSituacaoCadastral,
      atividadePrincipal: atividadePrincipal ?? this.atividadePrincipal,
      atividadesSecundarias: atividadesSecundarias ?? this.atividadesSecundarias,
      endereco: endereco ?? this.endereco,
      telefones: telefones ?? this.telefones,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'cnpj': cnpj,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'dataInicioAtividade': dataInicioAtividade,
      'matriz': matriz,
      'naturezaJuridica': naturezaJuridica?.toJson(),
      'porte': porte?.toJson(),
      'situacaoCadastral': situacaoCadastral?.toJson(),
      'motivoSituacaoCadastral': motivoSituacaoCadastral?.toJson(),
      'atividadePrincipal': atividadePrincipal?.toJson(),
      'atividadesSecundarias': atividadesSecundarias?.map((x) => x.toJson()).toList(),
      'endereco': endereco?.toJson(),
      'telefones': telefones?.map((x) => x.toJson()).toList(),
      'email': email,
    };
  }

  factory CnpjListarEmpresaDto.fromJson(Map<String, dynamic> map) {
    return CnpjListarEmpresaDto(
      cnpj: map['cnpj'] != null ? map['cnpj'] as String : null,
      razaoSocial: map['razao_social'] != null ? map['razao_social'] as String : null,
      nomeFantasia: map['nome_fantasia'] != null ? map['nome_fantasia'] as String : null,
      dataInicioAtividade: map['data_inicio_atividade'],
      matriz: map['matriz'] != null ? map['matriz'] as bool : null,
      naturezaJuridica: map['natureza_juridica'] != null
          ? AtividadePrincipal.fromJson(map['natureza_juridica'] as Map<String, dynamic>)
          : null,
      porte: map['porte'] != null ? AtividadePrincipal.fromJson(map['porte'] as Map<String, dynamic>) : null,
      situacaoCadastral: map['situacao_cadastral'] != null
          ? SituacaoCadastral.fromJson(map['situacao_cadastral'] as Map<String, dynamic>)
          : null,
      motivoSituacaoCadastral: map['motivo_situacao_cadastral'] != null
          ? AtividadePrincipal.fromJson(map['motivo_situacao_cadastral'] as Map<String, dynamic>)
          : null,
      atividadePrincipal: map['atividade_principal'] != null
          ? AtividadePrincipal.fromJson(map['atividade_principal'] as Map<String, dynamic>)
          : null,
      atividadesSecundarias: map['atividades_secundarias'] != null
          ? List<AtividadePrincipal>.from(
              (map['atividades_secundarias'] as List<dynamic>).map<AtividadePrincipal?>(
                (x) => AtividadePrincipal.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      endereco: map['endereco'] != null ? Endereco.fromJson(map['endereco'] as Map<String, dynamic>) : null,
      telefones: map['telefones'] != null
          ? List<Telefone>.from(
              (map['telefones'] as List<dynamic>).map<Telefone?>(
                (x) => Telefone.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
}

class AtividadePrincipal {
  String? codigo;
  String? descricao;

  AtividadePrincipal({
    this.codigo,
    this.descricao,
  });

  AtividadePrincipal copyWith({
    String? codigo,
    String? descricao,
  }) {
    return AtividadePrincipal(
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo': codigo,
      'descricao': descricao,
    };
  }

  factory AtividadePrincipal.fromJson(Map<String, dynamic> map) {
    return AtividadePrincipal(
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }
}

class Endereco {
  String? tipoLogradouro;
  String? logradouro;
  String? numero;
  String? bairro;
  String? cep;
  String? uf;
  Municipio? municipio;

  Endereco({
    this.tipoLogradouro,
    this.logradouro,
    this.numero,
    this.bairro,
    this.cep,
    this.uf,
    this.municipio,
  });

  Endereco copyWith({
    String? tipoLogradouro,
    String? logradouro,
    String? numero,
    String? bairro,
    String? cep,
    String? uf,
    Municipio? municipio,
  }) {
    return Endereco(
      tipoLogradouro: tipoLogradouro ?? this.tipoLogradouro,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      bairro: bairro ?? this.bairro,
      cep: cep ?? this.cep,
      uf: uf ?? this.uf,
      municipio: municipio ?? this.municipio,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tipo_logradouro': tipoLogradouro,
      'logradouro': logradouro,
      'numero': numero,
      'bairro': bairro,
      'cep': cep,
      'uf': uf,
      'municipio': municipio?.toJson(),
    };
  }

  factory Endereco.fromJson(Map<String, dynamic> map) {
    return Endereco(
      tipoLogradouro: map['tipo_logradouro'] != null ? map['tipo_logradouro'] as String : null,
      logradouro: map['logradouro'] != null ? map['logradouro'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      municipio: map['municipio'] != null ? Municipio.fromJson(map['municipio'] as Map<String, dynamic>) : null,
    );
  }
}

class Municipio {
  String? codigoTom;
  String? codigoIbge;
  String? descricao;

  Municipio({
    this.codigoTom,
    this.codigoIbge,
    this.descricao,
  });

  Municipio copyWith({
    String? codigoTom,
    String? codigoIbge,
    String? descricao,
  }) {
    return Municipio(
      codigoTom: codigoTom ?? this.codigoTom,
      codigoIbge: codigoIbge ?? this.codigoIbge,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'codigo_tom': codigoTom,
      'codigo_ibge': codigoIbge,
      'descricao': descricao,
    };
  }

  factory Municipio.fromJson(Map<String, dynamic> map) {
    return Municipio(
      codigoTom: map['codigo_tom'] != null ? map['codigo_tom'] as String : null,
      codigoIbge: map['codigo_ibge'] != null ? map['codigo_ibge'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }
}

class SituacaoCadastral {
  String? data;
  String? codigo;
  String? descricao;

  SituacaoCadastral({
    this.data,
    this.codigo,
    this.descricao,
  });

  SituacaoCadastral copyWith({
    String? data,
    String? codigo,
    String? descricao,
  }) {
    return SituacaoCadastral(
      data: data ?? this.data,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'data': data,
      'codigo': codigo,
      'descricao': descricao,
    };
  }

  factory SituacaoCadastral.fromJson(Map<String, dynamic> map) {
    return SituacaoCadastral(
      data: map['data'],
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }
}

class Telefone {
  String? ddd;
  String? numero;

  Telefone({
    this.ddd,
    this.numero,
  });

  Telefone copyWith({
    String? ddd,
    String? numero,
  }) {
    return Telefone(
      ddd: ddd ?? this.ddd,
      numero: numero ?? this.numero,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ddd': ddd,
      'numero': numero,
    };
  }

  factory Telefone.fromJson(Map<String, dynamic> map) {
    return Telefone(
      ddd: map['ddd'] != null ? map['ddd'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
    );
  }
}
