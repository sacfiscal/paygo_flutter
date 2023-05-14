// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'uf',
  primaryKeys: ['id'],
)
class UfEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  String? nome;
  int? codigoIbge;
  String? sigla;

  UfEntity({
    this.id,
    this.emitenteId,
    this.nome,
    this.codigoIbge,
    this.sigla,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'nome': nome,
      'codigoIbge': codigoIbge,
      'sigla': sigla,
    };
  }

  factory UfEntity.fromMap(Map<String, dynamic> map) {
    return UfEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      codigoIbge: map['codigoIbge'] != null ? map['codigoIbge'] as int : null,
      sigla: map['sigla'] != null ? map['sigla'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UfEntity.fromJson(String source) => UfEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UfEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.nome == nome &&
        other.codigoIbge == codigoIbge &&
        other.sigla == sigla;
  }

  @override
  int get hashCode => id.hashCode ^ emitenteId.hashCode ^ nome.hashCode ^ codigoIbge.hashCode ^ sigla.hashCode;

  @override
  String toString() =>
      'UfEntity( id: $id, emitenteId: $emitenteId, nome: $nome, codigoIbge: $codigoIbge, sigla: $sigla)';
}
