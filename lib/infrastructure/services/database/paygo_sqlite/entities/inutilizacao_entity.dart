// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'inutilizacao',
  primaryKeys: ['id'],
)
class InutilizacaoEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  int? tpAmb;
  int? serie;
  int? numeroInicial;
  int? numeroFinal;
  String? justificativa;
  String? dhInutilizacao;
  String? protocoloInutilizacao;

  InutilizacaoEntity({
    this.id,
    this.emitenteId,
    this.tpAmb,
    this.serie,
    this.numeroInicial,
    this.numeroFinal,
    this.justificativa,
    this.dhInutilizacao,
    this.protocoloInutilizacao,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'tpAmb': tpAmb,
      'serie': serie,
      'numeroInicial': numeroInicial,
      'numeroFinal': numeroFinal,
      'justificativa': justificativa,
      'dhInutilizacao': dhInutilizacao,
      'protocoloInutilizacao': protocoloInutilizacao,
    };
  }

  factory InutilizacaoEntity.fromMap(Map<String, dynamic> map) {
    return InutilizacaoEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      tpAmb: map['tpAmb'] != null ? map['tpAmb'] as int : null,
      serie: map['serie'] != null ? map['serie'] as int : null,
      numeroInicial: map['numeroInicial'] != null ? map['numeroInicial'] as int : null,
      numeroFinal: map['numeroFinal'] != null ? map['numeroFinal'] as int : null,
      justificativa: map['justificativa'] != null ? map['justificativa'] as String : null,
      dhInutilizacao: map['dhInutilizacao'] != null ? map['dhInutilizacao'] as String : null,
      protocoloInutilizacao: map['protocoloInutilizacao'] != null ? map['protocoloInutilizacao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InutilizacaoEntity.fromJson(String source) =>
      InutilizacaoEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant InutilizacaoEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.tpAmb == tpAmb &&
        other.serie == serie &&
        other.numeroInicial == numeroInicial &&
        other.numeroFinal == numeroFinal &&
        other.justificativa == justificativa &&
        other.dhInutilizacao == dhInutilizacao &&
        other.protocoloInutilizacao == protocoloInutilizacao;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        tpAmb.hashCode ^
        serie.hashCode ^
        numeroInicial.hashCode ^
        numeroFinal.hashCode ^
        justificativa.hashCode ^
        dhInutilizacao.hashCode ^
        protocoloInutilizacao.hashCode;
  }

  @override
  String toString() {
    return 'InutilizacaoEntity(id: $id, emitenteId: $emitenteId, tpAmb: $tpAmb, serie: $serie, numeroInicial: $numeroInicial, numeroFinal: $numeroFinal, justificativa: $justificativa, dhInutilizacao: $dhInutilizacao, protocoloInutilizacao: $protocoloInutilizacao)';
  }
}
