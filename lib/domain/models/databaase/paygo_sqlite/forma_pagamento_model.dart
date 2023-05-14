// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormaPagamentoModel {
  int? id;
  int? emitenteId;
  String? codSefaz;
  String? descricao;

  FormaPagamentoModel({
    this.id,
    this.emitenteId,
    this.codSefaz,
    this.descricao,
  });

  FormaPagamentoModel copyWith({
    int? id,
    int? emitenteId,
    String? codSefaz,
    String? descricao,
  }) {
    return FormaPagamentoModel(
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

  factory FormaPagamentoModel.fromMap(Map<String, dynamic> map) {
    return FormaPagamentoModel(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      codSefaz: map['codSefaz'] != null ? map['codSefaz'] as String : null,
      descricao: map['descricao'] != null ? map['descricao'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FormaPagamentoModel.fromJson(String source) =>
      FormaPagamentoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FormaPagamentoModel(id: $id, emitenteId: $emitenteId, codSefaz: $codSefaz, descricao: $descricao)';
  }

  @override
  bool operator ==(covariant FormaPagamentoModel other) {
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
