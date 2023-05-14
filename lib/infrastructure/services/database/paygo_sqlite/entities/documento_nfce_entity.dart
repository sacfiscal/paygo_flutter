// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@Entity(
  tableName: 'documentoNfce',
  primaryKeys: ['id'],
)
class DocumentoNfceEntity {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int? situacao = 0;

  int? emitenteId;
  int? destinatarioId;
  String? destinatarioRazaoSocial;
  String? destinatarioCnpjCpf;
  String? cnpjCpf;
  int? mod;
  int? serie;
  int? nNF;
  String? dhEmi;
  int? tpImp;
  int? tpEmis;
  int? tpAmb;
  int? finNFe;
  int? indFinal;
  int? indPres;
  double? vProd;
  double? vFrete;
  double? vSeg;
  double? vDesc;
  double? vOutro;
  double? vNF;

  String? dhCont;
  String? xJust;

  int? cStat;
  String? xMotivo;

  String? dhAutorizacao;
  String? protocoloAutorizacao;
  String? jsonAutorizacao;
  String? escpos;

  String? justificativa;
  String? dhCancelamento;
  String? protocoloCancelamento;
  String? jsonCancelamento;

  String? idUnico;
  String? chNFe;

  DocumentoNfceEntity({
    this.id,
    this.situacao = 0,
    this.emitenteId,
    this.destinatarioId,
    this.destinatarioRazaoSocial,
    this.destinatarioCnpjCpf,
    this.cnpjCpf,
    this.mod,
    this.serie,
    this.nNF,
    this.dhEmi,
    this.tpImp,
    this.tpEmis,
    this.tpAmb,
    this.finNFe,
    this.indFinal,
    this.indPres,
    this.vProd,
    this.vFrete,
    this.vSeg,
    this.vDesc,
    this.vOutro,
    this.vNF,
    this.dhCont,
    this.xJust,
    this.cStat,
    this.xMotivo,
    this.dhAutorizacao,
    this.protocoloAutorizacao,
    this.jsonAutorizacao,
    this.escpos,
    this.justificativa,
    this.dhCancelamento,
    this.protocoloCancelamento,
    this.jsonCancelamento,
    this.idUnico,
    this.chNFe,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'situacao': situacao,
      'emitenteId': emitenteId,
      'destinatarioId': destinatarioId,
      'destinatarioRazaoSocial': destinatarioRazaoSocial,
      'destinatarioCnpjCpf': destinatarioCnpjCpf,
      'cnpjCpf': cnpjCpf,
      'mod': mod,
      'serie': serie,
      'nNF': nNF,
      'dhEmi': dhEmi,
      'tpImp': tpImp,
      'tpEmis': tpEmis,
      'tpAmb': tpAmb,
      'finNFe': finNFe,
      'indFinal': indFinal,
      'indPres': indPres,
      'vProd': vProd,
      'vFrete': vFrete,
      'vSeg': vSeg,
      'vDesc': vDesc,
      'vOutro': vOutro,
      'vNF': vNF,
      'dhCont': dhCont,
      'xJust': xJust,
      'cStat': cStat,
      'xMotivo': xMotivo,
      'dhAutorizacao': dhAutorizacao,
      'protocoloAutorizacao': protocoloAutorizacao,
      'jsonAutorizacao': jsonAutorizacao,
      'escpos': escpos,
      'justificativa': justificativa,
      'dhCancelamento': dhCancelamento,
      'protocoloCancelamento': protocoloCancelamento,
      'jsonCancelamento': jsonCancelamento,
      'idUnico': idUnico,
      'chNFe': chNFe,
    };
  }

  factory DocumentoNfceEntity.fromMap(Map<String, dynamic> map) {
    return DocumentoNfceEntity(
      id: map['id'] != null ? map['id'] as int : null,
      situacao: map['situacao'] != null ? map['situacao'] as int : null,
      emitenteId: map['emitenteId'] != null ? map['emitenteId'] as int : null,
      destinatarioId: map['destinatarioId'] != null ? map['destinatarioId'] as int : null,
      destinatarioRazaoSocial: map['destinatarioRazaoSocial'] != null ? map['destinatarioRazaoSocial'] as String : null,
      destinatarioCnpjCpf: map['destinatarioCnpjCpf'] != null ? map['destinatarioCnpjCpf'] as String : null,
      cnpjCpf: map['cnpjCpf'] != null ? map['cnpjCpf'] as String : null,
      mod: map['mod'] != null ? map['mod'] as int : null,
      serie: map['serie'] != null ? map['serie'] as int : null,
      nNF: map['nNF'] != null ? map['nNF'] as int : null,
      dhEmi: map['dhEmi'] != null ? map['dhEmi'] as String : null,
      tpImp: map['tpImp'] != null ? map['tpImp'] as int : null,
      tpEmis: map['tpEmis'] != null ? map['tpEmis'] as int : null,
      tpAmb: map['tpAmb'] != null ? map['tpAmb'] as int : null,
      finNFe: map['finNFe'] != null ? map['finNFe'] as int : null,
      indFinal: map['indFinal'] != null ? map['indFinal'] as int : null,
      indPres: map['indPres'] != null ? map['indPres'] as int : null,
      vProd: map['vProd'] != null ? map['vProd'] as double : null,
      vFrete: map['vFrete'] != null ? map['vFrete'] as double : null,
      vSeg: map['vSeg'] != null ? map['vSeg'] as double : null,
      vDesc: map['vDesc'] != null ? map['vDesc'] as double : null,
      vOutro: map['vOutro'] != null ? map['vOutro'] as double : null,
      vNF: map['vNF'] != null ? map['vNF'] as double : null,
      dhCont: map['dhCont'] != null ? map['dhCont'] as String : null,
      xJust: map['xJust'] != null ? map['xJust'] as String : null,
      cStat: map['cStat'] != null ? map['cStat'] as int : null,
      xMotivo: map['xMotivo'] != null ? map['xMotivo'] as String : null,
      dhAutorizacao: map['dhAutorizacao'] != null ? map['dhAutorizacao'] as String : null,
      protocoloAutorizacao: map['protocoloAutorizacao'] != null ? map['protocoloAutorizacao'] as String : null,
      jsonAutorizacao: map['jsonAutorizacao'] != null ? map['jsonAutorizacao'] as String : null,
      escpos: map['escpos'] != null ? map['escpos'] as String : null,
      justificativa: map['justificativa'] != null ? map['justificativa'] as String : null,
      dhCancelamento: map['dhCancelamento'] != null ? map['dhCancelamento'] as String : null,
      protocoloCancelamento: map['protocoloCancelamento'] != null ? map['protocoloCancelamento'] as String : null,
      jsonCancelamento: map['jsonCancelamento'] != null ? map['jsonCancelamento'] as String : null,
      idUnico: map['idUnico'] != null ? map['idUnico'] as String : null,
      chNFe: map['chNFe'] != null ? map['chNFe'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentoNfceEntity.fromJson(String source) =>
      DocumentoNfceEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant DocumentoNfceEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.situacao == situacao &&
        other.emitenteId == emitenteId &&
        other.destinatarioId == destinatarioId &&
        other.destinatarioRazaoSocial == destinatarioRazaoSocial &&
        other.destinatarioCnpjCpf == destinatarioCnpjCpf &&
        other.cnpjCpf == cnpjCpf &&
        other.mod == mod &&
        other.serie == serie &&
        other.nNF == nNF &&
        other.dhEmi == dhEmi &&
        other.tpImp == tpImp &&
        other.tpEmis == tpEmis &&
        other.tpAmb == tpAmb &&
        other.finNFe == finNFe &&
        other.indFinal == indFinal &&
        other.indPres == indPres &&
        other.vProd == vProd &&
        other.vFrete == vFrete &&
        other.vSeg == vSeg &&
        other.vDesc == vDesc &&
        other.vOutro == vOutro &&
        other.vNF == vNF &&
        other.dhCont == dhCont &&
        other.xJust == xJust &&
        other.cStat == cStat &&
        other.xMotivo == xMotivo &&
        other.dhAutorizacao == dhAutorizacao &&
        other.protocoloAutorizacao == protocoloAutorizacao &&
        other.jsonAutorizacao == jsonAutorizacao &&
        other.escpos == escpos &&
        other.justificativa == justificativa &&
        other.dhCancelamento == dhCancelamento &&
        other.protocoloCancelamento == protocoloCancelamento &&
        other.jsonCancelamento == jsonCancelamento &&
        other.idUnico == idUnico &&
        other.chNFe == chNFe;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        situacao.hashCode ^
        emitenteId.hashCode ^
        destinatarioId.hashCode ^
        destinatarioRazaoSocial.hashCode ^
        destinatarioCnpjCpf.hashCode ^
        cnpjCpf.hashCode ^
        mod.hashCode ^
        serie.hashCode ^
        nNF.hashCode ^
        dhEmi.hashCode ^
        tpImp.hashCode ^
        tpEmis.hashCode ^
        tpAmb.hashCode ^
        finNFe.hashCode ^
        indFinal.hashCode ^
        indPres.hashCode ^
        vProd.hashCode ^
        vFrete.hashCode ^
        vSeg.hashCode ^
        vDesc.hashCode ^
        vOutro.hashCode ^
        vNF.hashCode ^
        dhCont.hashCode ^
        xJust.hashCode ^
        cStat.hashCode ^
        xMotivo.hashCode ^
        dhAutorizacao.hashCode ^
        protocoloAutorizacao.hashCode ^
        jsonAutorizacao.hashCode ^
        escpos.hashCode ^
        justificativa.hashCode ^
        dhCancelamento.hashCode ^
        protocoloCancelamento.hashCode ^
        jsonCancelamento.hashCode ^
        idUnico.hashCode ^
        chNFe.hashCode;
  }

  @override
  String toString() {
    return 'DocumentoNfceEntity(id: $id, situacao: $situacao, emitenteId: $emitenteId, destinatarioId: $destinatarioId, destinatarioRazaoSocial: $destinatarioRazaoSocial, destinatarioCnpjCpf: $destinatarioCnpjCpf, cnpjCpf: $cnpjCpf, mod: $mod, serie: $serie, nNF: $nNF, dhEmi: $dhEmi, tpImp: $tpImp, tpEmis: $tpEmis, tpAmb: $tpAmb, finNFe: $finNFe, indFinal: $indFinal, indPres: $indPres, vProd: $vProd, vFrete: $vFrete, vSeg: $vSeg, vDesc: $vDesc, vOutro: $vOutro, vNF: $vNF, dhCont: $dhCont, xJust: $xJust, cStat: $cStat, xMotivo: $xMotivo, dhAutorizacao: $dhAutorizacao, protocoloAutorizacao: $protocoloAutorizacao, jsonAutorizacao: $jsonAutorizacao, escpos: $escpos, justificativa: $justificativa, dhCancelamento: $dhCancelamento, protocoloCancelamento: $protocoloCancelamento, jsonCancelamento: $jsonCancelamento, idUnico: $idUnico, chNFe: $chNFe)';
  }
}
