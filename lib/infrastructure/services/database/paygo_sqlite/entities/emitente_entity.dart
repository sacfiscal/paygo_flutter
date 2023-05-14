// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'emitente',
  primaryKeys: ['id'],
)
class EmitenteEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;

  String? razaoSocial;
  String? nomeFantasia;
  String? cnpjCpf;
  String? logradouro;
  String? numero;
  String? complemento;
  String? bairro;
  String? codigoMunicipio;
  String? municipio;
  String? uf;
  String? cep;
  String? fone;
  String? ie;
  String? crt;
  String? idCsc;
  String? csc;

  EmitenteEntity({
    this.id,
    this.razaoSocial,
    this.nomeFantasia,
    this.cnpjCpf,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.codigoMunicipio,
    this.municipio,
    this.uf,
    this.cep,
    this.fone,
    this.ie,
    this.crt,
    this.idCsc,
    this.csc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'cnpjCpf': cnpjCpf,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'codigoMunicipio': codigoMunicipio,
      'municipio': municipio,
      'uf': uf,
      'cep': cep,
      'fone': fone,
      'ie': ie,
      'crt': crt,
      'idCsc': idCsc,
      'csc': csc,
    };
  }

  factory EmitenteEntity.fromMap(Map<String, dynamic> map) {
    return EmitenteEntity(
      id: map['id'] != null ? map['id'] as int : null,
      razaoSocial: map['razaoSocial'] != null ? map['razaoSocial'] as String : null,
      nomeFantasia: map['nomeFantasia'] != null ? map['nomeFantasia'] as String : null,
      cnpjCpf: map['cnpjCpf'] != null ? map['cnpjCpf'] as String : null,
      logradouro: map['logradouro'] != null ? map['logradouro'] as String : null,
      numero: map['numero'] != null ? map['numero'] as String : null,
      complemento: map['complemento'] != null ? map['complemento'] as String : null,
      bairro: map['bairro'] != null ? map['bairro'] as String : null,
      codigoMunicipio: map['codigoMunicipio'] != null ? map['codigoMunicipio'] as String : null,
      municipio: map['municipio'] != null ? map['municipio'] as String : null,
      uf: map['uf'] != null ? map['uf'] as String : null,
      cep: map['cep'] != null ? map['cep'] as String : null,
      fone: map['fone'] != null ? map['fone'] as String : null,
      ie: map['ie'] != null ? map['ie'] as String : null,
      crt: map['crt'] != null ? map['crt'] as String : null,
      idCsc: map['idCsc'] != null ? map['idCsc'] as String : null,
      csc: map['csc'] != null ? map['csc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmitenteEntity.fromJson(String source) => EmitenteEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant EmitenteEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.razaoSocial == razaoSocial &&
        other.nomeFantasia == nomeFantasia &&
        other.cnpjCpf == cnpjCpf &&
        other.logradouro == logradouro &&
        other.numero == numero &&
        other.complemento == complemento &&
        other.bairro == bairro &&
        other.codigoMunicipio == codigoMunicipio &&
        other.municipio == municipio &&
        other.uf == uf &&
        other.cep == cep &&
        other.fone == fone &&
        other.ie == ie &&
        other.crt == crt &&
        other.idCsc == idCsc &&
        other.csc == csc;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        razaoSocial.hashCode ^
        nomeFantasia.hashCode ^
        cnpjCpf.hashCode ^
        logradouro.hashCode ^
        numero.hashCode ^
        complemento.hashCode ^
        bairro.hashCode ^
        codigoMunicipio.hashCode ^
        municipio.hashCode ^
        uf.hashCode ^
        cep.hashCode ^
        fone.hashCode ^
        ie.hashCode ^
        crt.hashCode ^
        idCsc.hashCode ^
        csc.hashCode;
  }

  @override
  String toString() {
    return 'EmitenteEntity(id: $id, razaoSocial: $razaoSocial, nomeFantasia: $nomeFantasia, cnpjCpf: $cnpjCpf, logradouro: $logradouro, numero: $numero, complemento: $complemento, bairro: $bairro, codigoMunicipio: $codigoMunicipio, municipio: $municipio, uf: $uf, cep: $cep, fone: $fone, ie: $ie, crt: $crt, idCsc: $idCsc, csc: $csc)';
  }
}
