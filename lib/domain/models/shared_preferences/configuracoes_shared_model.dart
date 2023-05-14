import 'dart:convert';

import 'package:paygo_app/domain/models/application/printer_device_model.dart';

import '../api/nuvem_fiscal/autenticacao/access_token_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConfiguracoesSharedModel {
  DateTime? dataUltimoAcesso;
  bool? empresaIdentificada = false;
  bool? appLogado = false;
  bool? lembrarLogin = false;
  String? login = '';
  String? senha = '';
  AccessTokenModel? accessToken;
  int? emitenteId = 0;
  PrinterDeviceModel? impressora;
  String? ambiente;

  String get getAuthorization {
    if (accessToken?.accessToken != null) {
      return 'Bearer ${accessToken?.accessToken}';
    } else {
      return '';
    }
  }

  DateTime get getAuthorizationExpiresDate {
    return DateTime.now().add(Duration(seconds: accessToken!.expiresIn!));
  }

  void updateData(ConfiguracoesSharedModel configuracoesModel) {
    dataUltimoAcesso = configuracoesModel.dataUltimoAcesso;
    empresaIdentificada = configuracoesModel.empresaIdentificada;
    appLogado = configuracoesModel.appLogado;
    lembrarLogin = configuracoesModel.lembrarLogin;
    login = configuracoesModel.login;
    senha = configuracoesModel.senha;
    accessToken = configuracoesModel.accessToken;
    emitenteId = configuracoesModel.emitenteId;
    impressora = configuracoesModel.impressora;
    ambiente = configuracoesModel.ambiente;
  }

  ConfiguracoesSharedModel({
    this.dataUltimoAcesso,
    this.empresaIdentificada,
    this.appLogado,
    this.lembrarLogin,
    this.login,
    this.senha,
    this.accessToken,
    this.emitenteId,
    this.impressora,
    this.ambiente,
  }) {
    dataUltimoAcesso = dataUltimoAcesso ?? DateTime.now();
    empresaIdentificada = empresaIdentificada ?? false;
    appLogado = appLogado ?? false;
    lembrarLogin = lembrarLogin ?? false;
    login = login ?? '';
    senha = senha ?? '';
    emitenteId = emitenteId ?? 0;
    ambiente = ambiente ?? 'HOMOLOGACAO';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataUltimoAcesso': dataUltimoAcesso?.millisecondsSinceEpoch,
      'empresaIdentificada': empresaIdentificada,
      'appLogado': appLogado,
      'lembrarLogin': lembrarLogin,
      'login': login,
      'senha': senha,
      'accessToken': accessToken?.toMap(),
      'emitenteId': emitenteId ?? 0,
      'impressora': impressora?.toMap(),
      'ambiente': ambiente,
    };
  }

  factory ConfiguracoesSharedModel.fromMap(Map<String, dynamic> map) {
    return ConfiguracoesSharedModel(
      dataUltimoAcesso:
          map['dataUltimoAcesso'] != null ? DateTime.fromMillisecondsSinceEpoch(map['dataUltimoAcesso'] as int) : null,
      empresaIdentificada: map['empresaIdentificada'] as bool?,
      appLogado: map['appLogado'] as bool?,
      lembrarLogin: map['lembrarLogin'] as bool?,
      login: map['login'] as String?,
      senha: map['senha'] as String?,
      accessToken: map['accessToken'] != null
          ? AccessTokenModel.fromMap(
              map['accessToken'] as Map<String, dynamic>,
            )
          : null,
      emitenteId: map['emitenteId'] as int?,
      impressora:
          map['impressora'] != null ? PrinterDeviceModel.fromMap(map['impressora'] as Map<String, dynamic>) : null,
      ambiente: map['ambiente'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfiguracoesSharedModel.fromJson(String source) =>
      ConfiguracoesSharedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ConfiguracoesSharedModel other) {
    if (identical(this, other)) return true;

    return other.dataUltimoAcesso == dataUltimoAcesso &&
        other.empresaIdentificada == empresaIdentificada &&
        other.appLogado == appLogado &&
        other.lembrarLogin == lembrarLogin &&
        other.login == login &&
        other.senha == senha &&
        other.accessToken == accessToken &&
        other.emitenteId == emitenteId &&
        other.impressora == impressora &&
        other.ambiente == ambiente;
  }

  @override
  int get hashCode => dataUltimoAcesso.hashCode ^ appLogado.hashCode ^ accessToken.hashCode;
}
