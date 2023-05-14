import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../commons/constantes/nuvem_fiscal_config.dart';
import 'autenticacao_interceprot.dart';

part 'autenticacao_service.g.dart';

final BaseOptions option = BaseOptions(
  connectTimeout: const Duration(seconds: 50000),
  contentType: 'application/json',
);

@RestApi(baseUrl: NuvemFiscalConfig.accessTokenUrl)
abstract class AutenticacaoService {
  factory AutenticacaoService(
    Dio dio, {
    String baseUrl,
  }) = _AutenticacaoService;

  static AutenticacaoService create({
    required Dio dio,
  }) {
    final dio = Dio();
    dio.options = option;
    dio.interceptors.add(AutenticacaoInerceptor());
    return AutenticacaoService(dio);
  }

  @POST('/token')
  Future<String> getAccessToken({
    @Field('grant_type') String grantType = 'client_credentials',
    @Field('client_id') String clientId = NuvemFiscalConfig.clientId,
    @Field('client_secret') String clientSecret = NuvemFiscalConfig.clientSecret,
    @Field('scope') String scope = NuvemFiscalConfig.scope,
  });
}

class NuvemFiscalAuthenticationInerceptor {}
