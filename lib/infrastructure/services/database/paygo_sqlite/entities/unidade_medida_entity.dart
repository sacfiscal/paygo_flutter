// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'unidadeMedida',
  primaryKeys: ['id'],
)
class UnidadeMedidaEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  String? sigla;
  String? descricao;

  UnidadeMedidaEntity({
    this.id,
    this.emitenteId,
    this.sigla,
    this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'sigla': sigla,
      'descricao': descricao,
    };
  }

  factory UnidadeMedidaEntity.fromMap(Map<String, dynamic> map) {
    return UnidadeMedidaEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      sigla: map['sigla'] != null ? map['sigla'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UnidadeMedidaEntity.fromJson(String source) =>
      UnidadeMedidaEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UnidadeMedidaEntity other) {
    if (identical(this, other)) return true;

    return other.id == id && other.emitenteId == emitenteId && other.sigla == sigla && other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ emitenteId.hashCode ^ sigla.hashCode;

  @override
  String toString() => 'UnidadeMedidaEntity(id: $id, emitenteId: $emitenteId, sigla: $sigla, descricao: $descricao)';
}
