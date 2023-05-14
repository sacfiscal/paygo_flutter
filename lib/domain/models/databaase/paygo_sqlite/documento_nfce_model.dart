// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DocumentoNfceModel {
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

  DocumentoNfceModel({
    this.id,
    this.situacao = 0,
    this.emitenteId,
    this.destinatarioId,
    this.destinatarioRazaoSocial,
    this.destinatarioCnpjCpf,
    this.cnpjCpf = '',
    this.mod = 65,
    this.serie,
    this.nNF,
    this.dhEmi,
    this.tpImp = 4,
    this.tpEmis = 1,
    this.tpAmb = 2,
    this.finNFe = 1,
    this.indFinal = 1,
    this.indPres = 1,
    this.vProd = 0,
    this.vFrete = 0,
    this.vSeg = 0,
    this.vDesc = 0,
    this.vOutro = 0,
    this.vNF = 0,
    this.dhCont,
    this.xJust = '',
    this.cStat = 0,
    this.xMotivo = 'Não emitido',
    this.dhAutorizacao,
    this.protocoloAutorizacao = '',
    this.jsonAutorizacao = '',
    this.escpos = '',
    this.justificativa = '',
    this.dhCancelamento,
    this.protocoloCancelamento = '',
    this.jsonCancelamento = '',
    this.idUnico = '',
    this.chNFe = '',
  });

  String obterStatusNFCe() {
    return '${cStat ?? 0} - ${xMotivo ?? 'Não emitido'}';
  }

  DocumentoNfceModel copyWith({
    int? id,
    int? situacao,
    int? emitenteId,
    int? destinatarioId,
    String? destinatarioRazaoSocial,
    String? destinatarioCnpjCpf,
    String? cnpjCpf,
    int? mod,
    int? serie,
    int? nNF,
    String? dhEmi,
    int? tpImp,
    int? tpEmis,
    int? tpAmb,
    int? finNFe,
    int? indFinal,
    int? indPres,
    double? vProd,
    double? vFrete,
    double? vSeg,
    double? vDesc,
    double? vOutro,
    double? vNF,
    String? dhCont,
    String? xJust,
    int? cStat,
    String? xMotivo,
    String? dhAutorizacao,
    String? protocoloAutorizacao,
    String? jsonAutorizacao,
    String? escpos,
    String? justificativa,
    String? dhCancelamento,
    String? protocoloCancelamento,
    String? jsonCancelamento,
    String? idUnico,
    String? chNFe,
  }) {
    return DocumentoNfceModel(
      id: id ?? this.id,
      situacao: situacao ?? this.situacao,
      emitenteId: emitenteId ?? this.emitenteId,
      destinatarioId: destinatarioId ?? this.destinatarioId,
      destinatarioRazaoSocial: destinatarioRazaoSocial ?? this.destinatarioRazaoSocial,
      destinatarioCnpjCpf: destinatarioCnpjCpf ?? this.destinatarioCnpjCpf,
      cnpjCpf: cnpjCpf ?? this.cnpjCpf,
      mod: mod ?? this.mod,
      serie: serie ?? this.serie,
      nNF: nNF ?? this.nNF,
      dhEmi: dhEmi ?? this.dhEmi,
      tpImp: tpImp ?? this.tpImp,
      tpEmis: tpEmis ?? this.tpEmis,
      tpAmb: tpAmb ?? this.tpAmb,
      finNFe: finNFe ?? this.finNFe,
      indFinal: indFinal ?? this.indFinal,
      indPres: indPres ?? this.indPres,
      vProd: vProd ?? this.vProd,
      vFrete: vFrete ?? this.vFrete,
      vSeg: vSeg ?? this.vSeg,
      vDesc: vDesc ?? this.vDesc,
      vOutro: vOutro ?? this.vOutro,
      vNF: vNF ?? this.vNF,
      dhCont: dhCont ?? this.dhCont,
      xJust: xJust ?? this.xJust,
      cStat: cStat ?? this.cStat,
      xMotivo: xMotivo ?? this.xMotivo,
      dhAutorizacao: dhAutorizacao ?? this.dhAutorizacao,
      protocoloAutorizacao: protocoloAutorizacao ?? this.protocoloAutorizacao,
      jsonAutorizacao: jsonAutorizacao ?? this.jsonAutorizacao,
      escpos: escpos ?? this.escpos,
      justificativa: justificativa ?? this.justificativa,
      dhCancelamento: dhCancelamento ?? this.dhCancelamento,
      protocoloCancelamento: protocoloCancelamento ?? this.protocoloCancelamento,
      jsonCancelamento: jsonCancelamento ?? this.jsonCancelamento,
      idUnico: idUnico ?? this.idUnico,
      chNFe: chNFe ?? this.chNFe,
    );
  }

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

  factory DocumentoNfceModel.fromMap(Map<String, dynamic> map) {
    return DocumentoNfceModel(
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

  factory DocumentoNfceModel.fromJson(String source) =>
      DocumentoNfceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DocumentoNfceModel(id: $id, situacao: $situacao, emitenteId: $emitenteId, destinatarioId: $destinatarioId, destinatarioRazaoSocial: $destinatarioRazaoSocial, destinatarioCnpjCpf: $destinatarioCnpjCpf, cnpjCpf: $cnpjCpf, mod: $mod, serie: $serie, nNF: $nNF, dhEmi: $dhEmi, tpImp: $tpImp, tpEmis: $tpEmis, tpAmb: $tpAmb, finNFe: $finNFe, indFinal: $indFinal, indPres: $indPres, vProd: $vProd, vFrete: $vFrete, vSeg: $vSeg, vDesc: $vDesc, vOutro: $vOutro, vNF: $vNF, dhCont: $dhCont, xJust: $xJust, cStat: $cStat, xMotivo: $xMotivo, dhAutorizacao: $dhAutorizacao, protocoloAutorizacao: $protocoloAutorizacao, jsonAutorizacao: $jsonAutorizacao, escpos: $escpos, justificativa: $justificativa, dhCancelamento: $dhCancelamento, protocoloCancelamento: $protocoloCancelamento, jsonCancelamento: $jsonCancelamento, idUnico: $idUnico, chNFe: $chNFe)';
  }

  @override
  bool operator ==(covariant DocumentoNfceModel other) {
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
}
