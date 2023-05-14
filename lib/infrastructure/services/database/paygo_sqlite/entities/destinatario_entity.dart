// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'destinatario',
  primaryKeys: ['id'],
)
class DestinatarioEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  int? emitenteId;
  String? cnpjCpf;
  String? idEstrangeiro;
  String? razaoSocial;
  String? nomeFantasia;
  String? logradouro;
  String? numero;
  String? complemento;
  String? bairro;
  String? codigoMunicipio;
  String? municipio;
  String? uf;
  String? cep;
  String? fone;
  String? indIeDest;
  String? ie;
  String? email;

  DestinatarioEntity({
    this.id,
    this.emitenteId,
    this.cnpjCpf,
    this.idEstrangeiro,
    this.razaoSocial,
    this.nomeFantasia,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.codigoMunicipio,
    this.municipio,
    this.uf,
    this.cep,
    this.fone,
    this.indIeDest,
    this.ie,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'cnpjCpf': cnpjCpf,
      'idEstrangeiro': idEstrangeiro,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'codigoMunicipio': codigoMunicipio,
      'municipio': municipio,
      'uf': uf,
      'cep': cep,
      'fone': fone,
      'indIeDest': indIeDest,
      'ie': ie,
      'email': email,
    };
  }

  factory DestinatarioEntity.fromMap(Map<String, dynamic> map) {
    return DestinatarioEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      cnpjCpf: map['cnpjCpf'] != null ? map['cnpjCpf'] as String : null,
      idEstrangeiro: map['idEstrangeiro'] != null ? map['idEstrangeiro'] as String : null,
      razaoSocial: map['razaoSocial'] != null ? map['razaoSocial'] as String : null,
      nomeFantasia: map['nomeFantasia'] != null ? map['nomeFantasia'] as String : null,
      logradouro: map['logradouro'] != null ? map['logradouro'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
      complemento: map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      codigoMunicipio: map['codigoMunicipio'] != null ? map['codigoMunicipio'] as String : null,
      municipio: map['municipio'] != null ? map['municipio'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      fone: map['fone'] != null ? map['fone'] as String : null,
      indIeDest: map['indIeDest'] != null ? map['indIeDest'] as String : null,
      ie: map['ie'] != null ? map['ie'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DestinatarioEntity.fromJson(String source) =>
      DestinatarioEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant DestinatarioEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.cnpjCpf == cnpjCpf &&
        other.idEstrangeiro == idEstrangeiro &&
        other.razaoSocial == razaoSocial &&
        other.nomeFantasia == nomeFantasia &&
        other.logradouro == logradouro &&
        other.numero == numero &&
        other.complemento == complemento &&
        other.bairro == bairro &&
        other.codigoMunicipio == codigoMunicipio &&
        other.municipio == municipio &&
        other.uf == uf &&
        other.cep == cep &&
        other.fone == fone &&
        other.indIeDest == indIeDest &&
        other.ie == ie &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        cnpjCpf.hashCode ^
        idEstrangeiro.hashCode ^
        razaoSocial.hashCode ^
        nomeFantasia.hashCode ^
        logradouro.hashCode ^
        numero.hashCode ^
        complemento.hashCode ^
        bairro.hashCode ^
        codigoMunicipio.hashCode ^
        municipio.hashCode ^
        uf.hashCode ^
        cep.hashCode ^
        fone.hashCode ^
        indIeDest.hashCode ^
        ie.hashCode ^
        email.hashCode;
  }

  @override
  String toString() {
    return 'DestinatarioEntity(id: $id, emitenteId: $emitenteId, cnpjCpf: $cnpjCpf, idEstrangeiro: $idEstrangeiro, razaoSocial: $razaoSocial, nomeFantasia: $nomeFantasia, logradouro: $logradouro, numero: $numero, complemento: $complemento, bairro: $bairro, codigoMunicipio: $codigoMunicipio, municipio: $municipio, uf: $uf, cep: $cep, fone: $fone, indIeDest: $indIeDest, ie: $ie, email: $email)';
  }
}
