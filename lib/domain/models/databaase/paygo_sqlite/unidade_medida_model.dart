// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UnidadeMedidaModel {
  int? id;
  int? emitenteId;
  String? sigla;
  String? descricao;

  UnidadeMedidaModel({
    this.id,
    this.emitenteId,
    this.sigla,
    this.descricao,
  });

  UnidadeMedidaModel copyWith({
    int? id,
    int? emitenteId,
    String? sigla,
    String? descricao,
  }) {
    return UnidadeMedidaModel(
      id: id ?? this.id,
      emitenteId: emitenteId ?? this.emitenteId,
      sigla: sigla ?? this.sigla,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'sigla': sigla,
      'descricao': descricao,
    };
  }

  factory UnidadeMedidaModel.fromMap(Map<String, dynamic> map) {
    return UnidadeMedidaModel(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      sigla: map['sigla'] != null ? map['sigla'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnidadeMedidaModel.fromJson(String source) =>
      UnidadeMedidaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UnidadeMedidaModel(id: $id, emitenteId: $emitenteId, sigla: $sigla, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant UnidadeMedidaModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.emitenteId == emitenteId && other.sigla == sigla && other.descricao == descricao;
  }

  @override
  int get hashCode {
    return id.hashCode ^ emitenteId.hashCode ^ sigla.hashCode ^ descricao.hashCode;
  }
}
