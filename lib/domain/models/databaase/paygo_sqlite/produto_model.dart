// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProdutoModel {
  int? id;
  int? emitenteId;
  String? codigo;
  String? cean;
  String? cbarra;
  String? descricao;
  String? ncm;
  String? cest;
  int? cfop;
  String? unidade;
  double? valor;
  String? codigoAnp;
  String? origem;
  String? cstIcms;
  String? cstpiscofins;
  bool? ativo;

  ProdutoModel({
    this.id,
    this.emitenteId,
    this.codigo,
    this.cean,
    this.cbarra,
    this.descricao,
    this.ncm,
    this.cest,
    this.cfop,
    this.unidade,
    this.valor,
    this.codigoAnp,
    this.origem,
    this.cstIcms,
    this.cstpiscofins,
    this.ativo,
  });

  ProdutoModel copyWith({
    int? id,
    int? emitenteId,
    String? codigo,
    String? cean,
    String? cbarra,
    String? descricao,
    String? ncm,
    String? cest,
    int? cfop,
    String? unidade,
    double? valor,
    String? codigoAnp,
    String? origem,
    String? cstIcms,
    String? cstpiscofins,
    bool? ativo,
  }) {
    return ProdutoModel(
      id: id ?? this.id,
      emitenteId: emitenteId ?? this.emitenteId,
      codigo: codigo ?? this.codigo,
      cean: cean ?? this.cean,
      cbarra: cbarra ?? this.cbarra,
      descricao: descricao ?? this.descricao,
      ncm: ncm ?? this.ncm,
      cest: cest ?? this.cest,
      cfop: cfop ?? this.cfop,
      unidade: unidade ?? this.unidade,
      valor: valor ?? this.valor,
      codigoAnp: codigoAnp ?? this.codigoAnp,
      origem: origem ?? this.origem,
      cstIcms: cstIcms ?? this.cstIcms,
      cstpiscofins: cstpiscofins ?? this.cstpiscofins,
      ativo: ativo ?? this.ativo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'codigo': codigo,
      'cean': cean,
      'cbarra': cbarra,
      'descricao': descricao,
      'ncm': ncm,
      'cest': cest,
      'cfop': cfop,
      'unidade': unidade,
      'valor': valor,
      'codigoAnp': codigoAnp,
      'origem': origem,
      'cstIcms': cstIcms,
      'cstpiscofins': cstpiscofins,
      'ativo': ativo,
    };
  }

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      codigo: map['codigo'] != null ? map['codigo'] as String : null,
      cean: map['cean'] != null ? map['cean'] as String : null,
      cbarra: map['cbarra'] != null ? map['cbarra'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
      ncm: map['ncm'] != null ? map['ncm'] as String : null,
      cest: map['cest'] != null ? map['cest'] as String : null,
      cfop: map['cfop'] != null ? map['cfop'] as int : null,
      unidade: map['unidade'] != null ? map['unidade'] as String : null,
      valor: map['valor'] != null ? map['valor'] as double : null,
      codigoAnp: map['codigoAnp'] != null ? map['codigoAnp'] as String : null,
      origem: map['origem'] != null ? map['origem'] as String : null,
      cstIcms: map['cstIcms'] != null ? map['cstIcms'] as String : null,
      cstpiscofins: map['cstpiscofins'] != null ? map['cstpiscofins'] as String : null,
      ativo: map['ativo'] != null ? map['ativo'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdutoModel.fromJson(String source) => ProdutoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProdutoModel(id: $id, emitenteId: $emitenteId, codigo: $codigo, cean: $cean, cbarra: $cbarra, descricao: $descricao, ncm: $ncm, cest: $cest, cfop: $cfop, unidade: $unidade, valor: $valor, codigoAnp: $codigoAnp, origem: $origem, cstIcms: $cstIcms, cstpiscofins: $cstpiscofins, ativo: $ativo)';
  }

  @override
  bool operator ==(covariant ProdutoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.codigo == codigo &&
        other.cean == cean &&
        other.cbarra == cbarra &&
        other.descricao == descricao &&
        other.ncm == ncm &&
        other.cest == cest &&
        other.cfop == cfop &&
        other.unidade == unidade &&
        other.valor == valor &&
        other.codigoAnp == codigoAnp &&
        other.origem == origem &&
        other.cstIcms == cstIcms &&
        other.cstpiscofins == cstpiscofins &&
        other.ativo == ativo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        codigo.hashCode ^
        cean.hashCode ^
        cbarra.hashCode ^
        descricao.hashCode ^
        ncm.hashCode ^
        cest.hashCode ^
        cfop.hashCode ^
        unidade.hashCode ^
        valor.hashCode ^
        codigoAnp.hashCode ^
        origem.hashCode ^
        cstIcms.hashCode ^
        cstpiscofins.hashCode ^
        ativo.hashCode;
  }
}
