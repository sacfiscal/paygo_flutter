// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'usuario',
  primaryKeys: ['id'],
)
class UsuarioEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  int? emitenteId;
  String? nome;
  String? login;
  String? senha;

  UsuarioEntity({
    this.id,
    this.emitenteId,
    this.nome,
    this.login,
    this.senha,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'nome': nome,
      'login': login,
      'senha': senha,
    };
  }

  factory UsuarioEntity.fromMap(Map<String, dynamic> map) {
    return UsuarioEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      login: map['login'] != null ? map['login'] as String : null,
      senha: map['senha'] != null ? map['senha'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UsuarioEntity.fromJson(String source) => UsuarioEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UsuarioEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.nome == nome &&
        other.login == login &&
        other.senha == senha;
  }

  @override
  int get hashCode {
    return id.hashCode ^ emitenteId.hashCode ^ nome.hashCode ^ login.hashCode ^ senha.hashCode;
  }

  @override
  String toString() {
    return 'UsuarioEntity(id: $id, emitenteId: $emitenteId, nome: $nome, login: $login, senha: $senha)';
  }
}
