class EmpresaConfiguracaoNfceDto {
  EmpresaConfiguracaoNfceDto({
    required this.ambiente,
    required this.crt,
    required this.sefaz,
  });

  String ambiente;
  int crt;
  EmpresaConfiguracaoNfceDtoSefaz sefaz;

  factory EmpresaConfiguracaoNfceDto.fromJson(Map<String, dynamic> json) => EmpresaConfiguracaoNfceDto(
        ambiente: json["ambiente"],
        crt: json["CRT"],
        sefaz: EmpresaConfiguracaoNfceDtoSefaz.fromJson(json["sefaz"]),
      );

  Map<String, dynamic> toJson() => {
        "ambiente": ambiente,
        "CRT": crt,
        "sefaz": sefaz.toJson(),
      };
}

class EmpresaConfiguracaoNfceDtoSefaz {
  EmpresaConfiguracaoNfceDtoSefaz({
    required this.idCsc,
    required this.csc,
  });

  int idCsc;
  String csc;

  factory EmpresaConfiguracaoNfceDtoSefaz.fromJson(Map<String, dynamic> json) => EmpresaConfiguracaoNfceDtoSefaz(
        idCsc: json["id_csc"],
        csc: json["csc"],
      );

  Map<String, dynamic> toJson() => {
        "id_csc": idCsc,
        "csc": csc,
      };
}
