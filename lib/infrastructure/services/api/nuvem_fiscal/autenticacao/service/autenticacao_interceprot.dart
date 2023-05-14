import 'package:dio/dio.dart';

class AutenticacaoInerceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // options.headers['Authorization'] = 'Bearer ${Get.find<ApplicationController>().configuracoesModel.accessToken?.accessToken}';
    // options.headers['Content-Type'] = 'application/json';
    // options.headers['Accept'] = 'application/json';

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
    return super.onError(err, handler);
  }
}
