// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'documentoNfceItem',
  primaryKeys: ['id'],
)
class DocumentoNfceItemEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? emitenteId;

  int? documentoId;
  int? produtoId;
  int? cProd;
  String? produtoDescricao;
  String? uCom;
  double? qCom;
  double? vUnCom;
  double? vProd;
  double? vFrete;
  double? vSeg;
  double? vDesc;
  double? vOutro;

  DocumentoNfceItemEntity({
    this.id,
    this.emitenteId,
    this.documentoId,
    this.produtoId,
    this.cProd,
    this.produtoDescricao,
    this.uCom,
    this.qCom,
    this.vUnCom,
    this.vProd,
    this.vFrete,
    this.vSeg,
    this.vDesc,
    this.vOutro,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emitenteId': emitenteId,
      'documentoId': documentoId,
      'produtoId': produtoId,
      'cProd': cProd,
      'produtoDescricao': produtoDescricao,
      'uCom': uCom,
      'qCom': qCom,
      'vUnCom': vUnCom,
      'vProd': vProd,
      'vFrete': vFrete,
      'vSeg': vSeg,
      'vDesc': vDesc,
      'vOutro': vOutro,
    };
  }

  factory DocumentoNfceItemEntity.fromMap(Map<String, dynamic> map) {
    return DocumentoNfceItemEntity(
      id: map['id'] != null ? map['id'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      documentoId: map['documentoId'] != null ? map['documentoId'] as int : null,
      produtoId: map['produtoId'] != null ? map['produtoId'] as int : null,
      cProd: map['cProd'] != null ? map['cProd'] as int : null,
      produtoDescricao: map['produtoDescricao'] != null ? map['produtoDescricao'] as String : null,
      uCom: map['uCom'] != null ? map['uCom'] as String : null,
      qCom: map['qCom'] != null ? map['qCom'] as double : null,
      vUnCom: map['vUnCom'] != null ? map['vUnCom'] as double : null,
      vProd: map['vProd'] != null ? map['vProd'] as double : null,
      vFrete: map['vFrete'] != null ? map['vFrete'] as double : null,
      vSeg: map['vSeg'] != null ? map['vSeg'] as double : null,
      vDesc: map['vDesc'] != null ? map['vDesc'] as double : null,
      vOutro: map['vOutro'] != null ? map['vOutro'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentoNfceItemEntity.fromJson(String source) =>
      DocumentoNfceItemEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant DocumentoNfceItemEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.emitenteId == emitenteId &&
        other.documentoId == documentoId &&
        other.produtoId == produtoId &&
        other.cProd == cProd &&
        other.produtoDescricao == produtoDescricao &&
        other.uCom == uCom &&
        other.qCom == qCom &&
        other.vUnCom == vUnCom &&
        other.vProd == vProd &&
        other.vFrete == vFrete &&
        other.vSeg == vSeg &&
        other.vDesc == vDesc &&
        other.vOutro == vOutro;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        emitenteId.hashCode ^
        documentoId.hashCode ^
        produtoId.hashCode ^
        cProd.hashCode ^
        produtoDescricao.hashCode ^
        uCom.hashCode ^
        qCom.hashCode ^
        vUnCom.hashCode ^
        vProd.hashCode ^
        vFrete.hashCode ^
        vSeg.hashCode ^
        vDesc.hashCode ^
        vOutro.hashCode;
  }

  @override
  String toString() {
    return 'DocumentoNfceItemEntity(id: $id, emitenteId: $emitenteId, documentoId: $documentoId, produtoId: $produtoId, cProd: $cProd, produtoDescricao: $produtoDescricao, uCom: $uCom, qCom: $qCom, vUnCom: $vUnCom, vProd: $vProd, vFrete: $vFrete, vSeg: $vSeg, vDesc: $vDesc, vOutro: $vOutro)';
  }
}
