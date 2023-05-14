// To parse this JSON data, do
//
//     final nfcePedidoEmissaoDto = nfcePedidoEmissaoDtoFromJson(jsonString);

import 'dart:convert';

NfcePedidoEmissaoDto nfcePedidoEmissaoDtoFromJson(String str) => NfcePedidoEmissaoDto.fromJson(json.decode(str));

String nfcePedidoEmissaoDtoToJson(NfcePedidoEmissaoDto data) => json.encode(data.toJson());

class NfcePedidoEmissaoDto {
  NfcePedidoEmissaoDto({
    required this.ambiente,
    this.infNFe,
  });

  String ambiente;
  InfNFe? infNFe;

  factory NfcePedidoEmissaoDto.fromJson(Map<String, dynamic> json) => NfcePedidoEmissaoDto(
        ambiente: json["ambiente"],
        infNFe: InfNFe.fromJson(json["infNFe"]),
      );

  Map<String, dynamic> toJson() => {
        "ambiente": ambiente,
        "infNFe": infNFe?.toJson(),
      };
}

class InfNFe {
  InfNFe({
    required this.versao,
    required this.ide,
    required this.emit,
    this.dest,
    required this.det,
    required this.total,
    required this.transp,
    required this.pag,
    required this.infAdic,
  });

  String versao;
  Ide ide;
  Emit emit;
  Dest? dest;
  List<Det> det;
  Total total;
  Transp transp;
  Pag pag;
  InfAdic infAdic;

  factory InfNFe.fromJson(Map<String, dynamic> json) => InfNFe(
        versao: json["versao"],
        ide: Ide.fromJson(json["ide"]),
        emit: Emit.fromJson(json["emit"]),
        dest: Dest.fromJson(json["dest"]),
        det: List<Det>.from(json["det"].map((x) => Det.fromJson(x))),
        total: Total.fromJson(json["total"]),
        transp: Transp.fromJson(json["transp"]),
        pag: Pag.fromJson(json["pag"]),
        infAdic: InfAdic.fromJson(json["infAdic"]),
      );

  Map<String, dynamic> toJson() => {
        "versao": versao,
        "ide": ide.toJson(),
        "emit": emit.toJson(),
        "dest": (dest != null) ? dest!.toJson() : null,
        "det": List<dynamic>.from(det.map((x) => x.toJson())),
        "total": total.toJson(),
        "transp": transp.toJson(),
        "pag": pag.toJson(),
        "infAdic": infAdic.toJson(),
      };
}

class Dest {
  Dest({
    this.cnpj,
    this.cpf,
    this.xNome,
    this.enderDest,
    this.indIeDest,
  });

  String? cnpj;
  String? cpf;
  String? xNome;
  Ender? enderDest;
  int? indIeDest;

  factory Dest.fromJson(Map<String, dynamic> json) => Dest(
        cnpj: json["CNPJ"],
        cpf: json["CPF"],
        xNome: json["xNome"],
        enderDest: Ender.fromJson(json["enderDest"]),
        indIeDest: json["indIEDest"],
      );

  Map<String, dynamic> toJson() => {
        "CNPJ": cnpj,
        "CPF": cpf,
        "xNome": xNome,
        "enderDest": (enderDest != null) ? enderDest!.toJson() : null,
        "indIEDest": indIeDest,
      };
}

class Ender {
  Ender({
    required this.xLgr,
    required this.nro,
    this.xCpl,
    required this.xBairro,
    required this.cMun,
    required this.xMun,
    required this.uf,
    required this.cep,
    required this.cPais,
    required this.xPais,
    required this.fone,
  });

  String xLgr;
  String nro;
  String? xCpl;
  String xBairro;
  String cMun;
  String xMun;
  String uf;
  String cep;
  String cPais;
  String xPais;
  String fone;

  factory Ender.fromJson(Map<String, dynamic> json) => Ender(
        xLgr: json["xLgr"],
        nro: json["nro"],
        xCpl: json["xCpl"],
        xBairro: json["xBairro"],
        cMun: json["cMun"],
        xMun: json["xMun"],
        uf: json["UF"],
        cep: json["CEP"],
        cPais: json["cPais"],
        xPais: json["xPais"],
        fone: json["fone"],
      );

  Map<String, dynamic> toJson() => {
        "xLgr": xLgr,
        "nro": nro,
        "xCpl": xCpl,
        "xBairro": xBairro,
        "cMun": cMun,
        "xMun": xMun,
        "UF": uf,
        "CEP": cep,
        "cPais": cPais,
        "xPais": xPais,
        "fone": fone,
      };
}

class Det {
  Det({
    required this.nItem,
    required this.prod,
    required this.imposto,
  });

  int nItem;
  Prod prod;
  Imposto imposto;

  factory Det.fromJson(Map<String, dynamic> json) => Det(
        nItem: json["nItem"],
        prod: Prod.fromJson(json["prod"]),
        imposto: Imposto.fromJson(json["imposto"]),
      );

  Map<String, dynamic> toJson() => {
        "nItem": nItem,
        "prod": prod.toJson(),
        "imposto": imposto.toJson(),
      };
}

class Imposto {
  Imposto({
    required this.vTotTrib,
    required this.icms,
  });

  int vTotTrib;
  Icms icms;

  factory Imposto.fromJson(Map<String, dynamic> json) => Imposto(
        vTotTrib: json["vTotTrib"],
        icms: Icms.fromJson(json["ICMS"]),
      );

  Map<String, dynamic> toJson() => {
        "vTotTrib": vTotTrib,
        "ICMS": icms.toJson(),
      };
}

class Icms {
  Icms({
    required this.icmssn102,
  });

  Icmssn102 icmssn102;

  factory Icms.fromJson(Map<String, dynamic> json) => Icms(
        icmssn102: Icmssn102.fromJson(json["ICMSSN102"]),
      );

  Map<String, dynamic> toJson() => {
        "ICMSSN102": icmssn102.toJson(),
      };
}

class Icmssn102 {
  Icmssn102({
    required this.orig,
    required this.csosn,
  });

  int orig;
  int csosn;

  factory Icmssn102.fromJson(Map<String, dynamic> json) => Icmssn102(
        orig: json["orig"],
        csosn: json["CSOSN"],
      );

  Map<String, dynamic> toJson() => {
        "orig": orig,
        "CSOSN": csosn,
      };
}

class Prod {
  Prod({
    required this.cProd,
    required this.cEan,
    required this.xProd,
    required this.ncm,
    required this.cest,
    required this.cfop,
    required this.uCom,
    required this.qCom,
    required this.vUnCom,
    required this.vProd,
    required this.cEanTrib,
    required this.uTrib,
    required this.qTrib,
    required this.vUnTrib,
    required this.indTot,
  });

  String cProd;
  String cEan;
  String xProd;
  String ncm;
  String cest;
  int cfop;
  String uCom;
  double qCom;
  double vUnCom;
  double vProd;
  String cEanTrib;
  String uTrib;
  double qTrib;
  double vUnTrib;
  int indTot;

  factory Prod.fromJson(Map<String, dynamic> json) => Prod(
        cProd: json["cProd"],
        cEan: json["cEAN"],
        xProd: json["xProd"],
        ncm: json["NCM"],
        cest: json["CEST"],
        cfop: json["CFOP"],
        uCom: json["uCom"],
        qCom: json["qCom"],
        vUnCom: json["vUnCom"]?.toDouble(),
        vProd: json["vProd"]?.toDouble(),
        cEanTrib: json["cEANTrib"],
        uTrib: json["uTrib"],
        qTrib: json["qTrib"],
        vUnTrib: json["vUnTrib"]?.toDouble(),
        indTot: json["indTot"],
      );

  Map<String, dynamic> toJson() => {
        "cProd": cProd,
        "cEAN": cEan,
        "xProd": xProd,
        "NCM": ncm,
        "CEST": cest,
        "CFOP": cfop,
        "uCom": uCom,
        "qCom": qCom,
        "vUnCom": vUnCom,
        "vProd": vProd,
        "cEANTrib": cEanTrib,
        "uTrib": uTrib,
        "qTrib": qTrib,
        "vUnTrib": vUnTrib,
        "indTot": indTot,
      };
}

class Emit {
  Emit({
    required this.cnpj,
    required this.xNome,
    required this.xFant,
    required this.enderEmit,
    required this.ie,
    required this.crt,
  });

  String cnpj;
  String xNome;
  String xFant;
  Ender enderEmit;
  String ie;
  int crt;

  factory Emit.fromJson(Map<String, dynamic> json) => Emit(
        cnpj: json["CNPJ"],
        xNome: json["xNome"],
        xFant: json["xFant"],
        enderEmit: Ender.fromJson(json["enderEmit"]),
        ie: json["IE"],
        crt: json["CRT"],
      );

  Map<String, dynamic> toJson() => {
        "CNPJ": cnpj,
        "xNome": xNome,
        "xFant": xFant,
        "enderEmit": enderEmit.toJson(),
        "IE": ie,
        "CRT": crt,
      };
}

class Ide {
  Ide({
    required this.cUf,
    required this.cNf,
    required this.natOp,
    required this.mod,
    required this.serie,
    required this.nNf,
    required this.dhEmi,
    required this.dhSaiEnt,
    required this.tpNf,
    required this.idDest,
    required this.cMunFg,
    required this.tpImp,
    required this.tpEmis,
    required this.cDv,
    required this.tpAmb,
    required this.finNFe,
    required this.indFinal,
    required this.indPres,
    required this.indIntermed,
    required this.procEmi,
    required this.verProc,
  });

  int cUf;
  String cNf;
  String natOp;
  int mod;
  int serie;
  int nNf;
  String dhEmi;
  String dhSaiEnt;
  int tpNf;
  int idDest;
  String cMunFg;
  int tpImp;
  int tpEmis;
  int cDv;
  int tpAmb;
  int finNFe;
  int indFinal;
  int indPres;
  int indIntermed;
  int procEmi;
  String verProc;

  factory Ide.fromJson(Map<String, dynamic> json) => Ide(
        cUf: json["cUF"],
        cNf: json["cNF"],
        natOp: json["natOp"],
        mod: json["mod"],
        serie: json["serie"],
        nNf: json["nNF"],
        dhEmi: json["dhEmi"],
        dhSaiEnt: json["dhSaiEnt"],
        tpNf: json["tpNF"],
        idDest: json["idDest"],
        cMunFg: json["cMunFG"],
        tpImp: json["tpImp"],
        tpEmis: json["tpEmis"],
        cDv: json["cDV"],
        tpAmb: json["tpAmb"],
        finNFe: json["finNFe"],
        indFinal: json["indFinal"],
        indPres: json["indPres"],
        indIntermed: json["indIntermed"],
        procEmi: json["procEmi"],
        verProc: json["verProc"],
      );

  Map<String, dynamic> toJson() => {
        "cUF": cUf,
        "cNF": cNf,
        "natOp": natOp,
        "mod": mod,
        "serie": serie,
        "nNF": nNf,
        "dhEmi": dhEmi,
        "dhSaiEnt": dhSaiEnt,
        "tpNF": tpNf,
        "idDest": idDest,
        "cMunFG": cMunFg,
        "tpImp": tpImp,
        "tpEmis": tpEmis,
        "cDV": cDv,
        "tpAmb": tpAmb,
        "finNFe": finNFe,
        "indFinal": indFinal,
        "indPres": indPres,
        "indIntermed": indIntermed,
        "procEmi": procEmi,
        "verProc": verProc,
      };
}

class InfAdic {
  InfAdic({
    required this.infCpl,
  });

  String infCpl;

  factory InfAdic.fromJson(Map<String, dynamic> json) => InfAdic(
        infCpl: json["infCpl"],
      );

  Map<String, dynamic> toJson() => {
        "infCpl": infCpl,
      };
}

class Pag {
  Pag({
    required this.detPag,
    required this.vTroco,
  });

  List<DetPag> detPag;
  int vTroco;

  factory Pag.fromJson(Map<String, dynamic> json) => Pag(
        detPag: List<DetPag>.from(json["detPag"].map((x) => DetPag.fromJson(x))),
        vTroco: json["vTroco"],
      );

  Map<String, dynamic> toJson() => {
        "detPag": List<dynamic>.from(detPag.map((x) => x.toJson())),
        "vTroco": vTroco,
      };
}

class DetPag {
  DetPag({
    required this.tPag,
    required this.vPag,
  });

  String tPag;
  double vPag;

  factory DetPag.fromJson(Map<String, dynamic> json) => DetPag(
        tPag: json["tPag"],
        vPag: json["vPag"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tPag": tPag,
        "vPag": vPag,
      };
}

class Total {
  Total({
    required this.icmsTot,
  });

  IcmsTot icmsTot;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        icmsTot: IcmsTot.fromJson(json["ICMSTot"]),
      );

  Map<String, dynamic> toJson() => {
        "ICMSTot": icmsTot.toJson(),
      };
}

class IcmsTot {
  IcmsTot({
    required this.vBc,
    required this.vIcms,
    required this.vIcmsDeson,
    required this.vFcpufDest,
    required this.vIcmsufDest,
    required this.vIcmsufRemet,
    required this.vFcp,
    required this.vBcst,
    required this.vSt,
    required this.vFcpst,
    required this.vFcpstRet,
    required this.vProd,
    required this.vFrete,
    required this.vSeg,
    required this.vDesc,
    required this.vIi,
    required this.vIpi,
    required this.vIpiDevol,
    required this.vPis,
    required this.vCofins,
    required this.vOutro,
    required this.vNf,
    required this.vTotTrib,
  });

  double vBc;
  double vIcms;
  double vIcmsDeson;
  double vFcpufDest;
  double vIcmsufDest;
  double vIcmsufRemet;
  double vFcp;
  double vBcst;
  double vSt;
  double vFcpst;
  double vFcpstRet;
  double vProd;
  double vFrete;
  double vSeg;

  double vDesc;
  double vIi;
  double vIpi;
  double vIpiDevol;
  double vPis;
  double vCofins;
  double vOutro;
  double vNf;
  double vTotTrib;

  factory IcmsTot.fromJson(Map<String, dynamic> json) => IcmsTot(
        vBc: json["vBC"],
        vIcms: json["vICMS"],
        vIcmsDeson: json["vICMSDeson"],
        vFcpufDest: json["vFCPUFDest"],
        vIcmsufDest: json["vICMSUFDest"],
        vIcmsufRemet: json["vICMSUFRemet"],
        vFcp: json["vFCP"],
        vBcst: json["vBCST"],
        vSt: json["vST"],
        vFcpst: json["vFCPST"],
        vFcpstRet: json["vFCPSTRet"],
        vProd: json["vProd"]?.toDouble(),
        vFrete: json["vFrete"],
        vSeg: json["vSeg"],
        vDesc: json["vDesc"],
        vIi: json["vII"],
        vIpi: json["vIPI"],
        vIpiDevol: json["vIPIDevol"],
        vPis: json["vPIS"],
        vCofins: json["vCOFINS"],
        vOutro: json["vOutro"],
        vNf: json["vNF"]?.toDouble(),
        vTotTrib: json["vTotTrib"],
      );

  Map<String, dynamic> toJson() => {
        "vBC": vBc,
        "vICMS": vIcms,
        "vICMSDeson": vIcmsDeson,
        "vFCPUFDest": vFcpufDest,
        "vICMSUFDest": vIcmsufDest,
        "vICMSUFRemet": vIcmsufRemet,
        "vFCP": vFcp,
        "vBCST": vBcst,
        "vST": vSt,
        "vFCPST": vFcpst,
        "vFCPSTRet": vFcpstRet,
        "vProd": vProd,
        "vFrete": vFrete,
        "vSeg": vSeg,
        "vDesc": vDesc,
        "vII": vIi,
        "vIPI": vIpi,
        "vIPIDevol": vIpiDevol,
        "vPIS": vPis,
        "vCOFINS": vCofins,
        "vOutro": vOutro,
        "vNF": vNf,
        "vTotTrib": vTotTrib,
      };
}

class Transp {
  Transp({
    required this.modFrete,
  });

  int modFrete;

  factory Transp.fromJson(Map<String, dynamic> json) => Transp(
        modFrete: json["modFrete"],
      );

  Map<String, dynamic> toJson() => {
        "modFrete": modFrete,
      };
}
