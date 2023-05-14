// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'bandeiraCartao',
  primaryKeys: ['id'],
)
class BandeiraCartaoEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  String? codSefaz;
  String? descricao;

  BandeiraCartaoEntity({
    this.id,
    this.emitenteId,
    this.codSefaz,
    this.descricao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'codSefaz': codSefaz,
      'descricao': descricao,
    };
  }

  factory BandeiraCartaoEntity.fromMap(Map<String, dynamic> map) {
    return BandeiraCartaoEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      codSefaz: map['codSefaz'] != null ? map['codSefaz'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BandeiraCartaoEntity.fromJson(String source) =>
      BandeiraCartaoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant BandeiraCartaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.codSefaz == codSefaz &&
        other.descricao == descricao;
  }

  @override
  int get hashCode => id.hashCode ^ emitenteId.hashCode ^ codSefaz.hashCode ^ descricao.hashCode;

  @override
  String toString() =>
      'BandeiraCartaoEntity(id: $id, emitenteId: $emitenteId, codSefaz: $codSefaz, descricao: $descricao)';
}
