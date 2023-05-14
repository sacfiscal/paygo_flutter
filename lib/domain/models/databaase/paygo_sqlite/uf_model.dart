// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UfModel {
  int? id;
  int? emitenteId;
  String? sigla;

  UfModel({
    this.id,
    this.emitenteId,
    this.sigla,
  });

  UfModel copyWith({
    int? id,
    int? emitenteId,
    String? sigla,
  }) {
    return UfModel(
      id: id ?? this.id,
      emitenteId: emitenteId ?? this.emitenteId,
      sigla: sigla ?? this.sigla,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'sigla': sigla,
    };
  }

  factory UfModel.fromMap(Map<String, dynamic> map) {
    return UfModel(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      sigla: map['sigla'] != null ? map['sigla'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UfModel.fromJson(String source) => UfModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UfModel(id: $id, emitenteId: $emitenteId, sigla: $sigla)';

  @override
  bool operator ==(covariant UfModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.emitenteId == emitenteId && other.sigla == sigla;
  }

  @override
  int get hashCode => id.hashCode ^ emitenteId.hashCode ^ sigla.hashCode;
}
