// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autenticacao_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AutenticacaoService implements AutenticacaoService {
  _AutenticacaoService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://auth.nuvemfiscal.com.br/oauth';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> getAccessToken({
    grantType = 'client_credentials',
    clientId = NuvemFiscalConfig.clientId,
    clientSecret = NuvemFiscalConfig.clientSecret,
    scope = NuvemFiscalConfig.scope,
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'grant_type': grantType,
      'client_id': clientId,
      'client_secret': clientSecret,
      'scope': scope,
    };
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/token',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
