// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'configuracoes',
  primaryKeys: ['id'],
)
class ConfiguracoesEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  int? emitenteId;
  String? serieNfce;
  int? ultimaNfce;
  String? arquivoCertificado;
  String? ambiente;

  ConfiguracoesEntity({
    this.id,
    this.emitenteId,
    this.serieNfce,
    this.ultimaNfce,
    this.arquivoCertificado,
    this.ambiente,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'serieNfce': serieNfce,
      'ultimaNfce': ultimaNfce,
      'arquivoCertificado': arquivoCertificado,
      'ambiente': ambiente,
    };
  }

  factory ConfiguracoesEntity.fromMap(Map<String, dynamic> map) {
    return ConfiguracoesEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      serieNfce: map['serieNfce'] != null ? map['serieNfce'] as String : null,
      ultimaNfce: map['ultimaNfce'] != null ? map['ultimaNfce'] as int : null,
      arquivoCertificado: map['arquivoCertificado'] != null ? map['arquivoCertificado'] as String : null,
      ambiente: map['ambiente'] != null ? map['ambiente'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfiguracoesEntity.fromJson(String source) =>
      ConfiguracoesEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ConfiguracoesEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.serieNfce == serieNfce &&
        other.ultimaNfce == ultimaNfce &&
        other.arquivoCertificado == arquivoCertificado &&
        other.ambiente == ambiente;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        serieNfce.hashCode ^
        ultimaNfce.hashCode ^
        arquivoCertificado.hashCode ^
        ambiente.hashCode;
  }

  @override
  String toString() {
    return 'ConfiguracoesEntity(id: $id, emitenteId: $emitenteId, serieNfce: $serieNfce, ultimaNfce: $ultimaNfce, arquivoCertificado: $arquivoCertificado, ambiente: $ambiente)';
  }
}
