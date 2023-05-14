import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as lib_get;
import 'package:logger/logger.dart';
import 'package:paygo_app/commons/functions/funcoes_api.dart';

import '../../../../../../domain/models/shared_preferences/configuracoes_shared_model.dart';

class DocumentosEletronicosInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    ConfiguracoesSharedModel configuracoesModel = lib_get.Get.find<ConfiguracoesSharedModel>();

    await refreshToken();

    if ((configuracoesModel.accessToken == null) ||
        (configuracoesModel.getAuthorizationExpiresDate.isBefore(DateTime.now()))) {
      await refreshToken();
      options.headers['Authorization'] = lib_get.Get.find<ConfiguracoesSharedModel>().getAuthorization;
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    String? erroMsg = '';

    lib_get.Get.find<Logger>().w(err.response?.data.runtimeType);
    lib_get.Get.find<Logger>().w(err.response?.data.toString());

    if (err.response?.statusCode == 400) {
      var decodeMSg = json.decode(err.response?.data);
      erroMsg = decodeMSg['error']['message'];
    } else {
      erroMsg = err.response?.data.toString();
    }

    return super.onError(
      DioError(
        requestOptions: err.requestOptions,
        response: err.response,
        error: err.error,
        type: err.type,
        message: erroMsg,
      ),
      handler,
    );
  }
}
