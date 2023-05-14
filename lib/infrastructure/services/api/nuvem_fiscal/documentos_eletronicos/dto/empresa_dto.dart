class EmpresaDto {
  EmpresaDto({
    required this.cpfCnpj,
    required this.createdAt,
    required this.updatedAt,
    required this.inscricaoEstadual,
    required this.nomeRazaoSocial,
    required this.nomeFantasia,
    required this.fone,
    required this.email,
    required this.endereco,
  });

  String cpfCnpj;
  DateTime createdAt;
  DateTime updatedAt;
  String inscricaoEstadual;
  String nomeRazaoSocial;
  String nomeFantasia;
  String fone;
  String email;
  Endereco endereco;

  factory EmpresaDto.fromJson(Map<String, dynamic> json) => EmpresaDto(
        cpfCnpj: json["cpf_cnpj"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        inscricaoEstadual: json["inscricao_estadual"],
        nomeRazaoSocial: json["nome_razao_social"],
        nomeFantasia: json["nome_fantasia"],
        fone: json["fone"],
        email: json["email"],
        endereco: Endereco.fromJson(json["endereco"]),
      );

  Map<String, dynamic> toJson() => {
        "cpf_cnpj": cpfCnpj,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "inscricao_estadual": inscricaoEstadual,
        "nome_razao_social": nomeRazaoSocial,
        "nome_fantasia": nomeFantasia,
        "fone": fone,
        "email": email,
        "endereco": endereco.toJson(),
      };
}

class Endereco {
  Endereco({
    required this.logradouro,
    required this.numero,
    required this.bairro,
    required this.codigoMunicipio,
    required this.cidade,
    required this.uf,
    required this.codigoPais,
    required this.pais,
    required this.cep,
  });

  String logradouro;
  String numero;
  String bairro;
  String codigoMunicipio;
  String cidade;
  String uf;
  String codigoPais;
  String pais;
  String cep;

  factory Endereco.fromJson(Map<String, dynamic> json) => Endereco(
        logradouro: json["logradouro"],
        numero: json["numero"],
        bairro: json["bairro"],
        codigoMunicipio: json["codigo_municipio"],
        cidade: json["cidade"],
        uf: json["uf"],
        codigoPais: json["codigo_pais"],
        pais: json["pais"],
        cep: json["cep"],
      );

  Map<String, dynamic> toJson() => {
        "logradouro": logradouro,
        "numero": numero,
        "bairro": bairro,
        "codigo_municipio": codigoMunicipio,
        "cidade": cidade,
        "uf": uf,
        "codigo_pais": codigoPais,
        "pais": pais,
        "cep": cep,
      };
}
