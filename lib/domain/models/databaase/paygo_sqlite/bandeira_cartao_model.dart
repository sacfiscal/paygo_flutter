// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BandeiraCartaoModel {
  int? id;
  int? emitenteId;
  String? codSefaz;
  String? descricao;

  BandeiraCartaoModel({
    this.id,
    this.emitenteId,
    this.codSefaz,
    this.descricao,
  });

  BandeiraCartaoModel copyWith({
    int? id,
    int? emitenteId,
    String? codSefaz,
    String? descricao,
  }) {
    return BandeiraCartaoModel(
      id: id ?? this.id,
      emitenteId: emitenteId ?? this.emitenteId,
      codSefaz: codSefaz ?? this.codSefaz,
      descricao: descricao ?? this.descricao,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'codSefaz': codSefaz,
      'descricao': descricao,
    };
  }

  factory BandeiraCartaoModel.fromMap(Map<String, dynamic> map) {
    return BandeiraCartaoModel(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      codSefaz: map['codSefaz'] != null ? map['codSefaz'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BandeiraCartaoModel.fromJson(String source) =>
      BandeiraCartaoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BandeiraCartaoModel(id: $id, emitenteId: $emitenteId, codSefaz: $codSefaz, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant BandeiraCartaoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.codSefaz == codSefaz &&
        other.descricao == descricao;
  }

  @override
  int get hashCode {
    return id.hashCode ^ emitenteId.hashCode ^ codSefaz.hashCode ^ descricao.hashCode;
  }
}
