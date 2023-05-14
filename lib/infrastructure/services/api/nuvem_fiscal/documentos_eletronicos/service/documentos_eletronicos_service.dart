import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../commons/constantes/nuvem_fiscal_config.dart';
import 'documentos_eletronicos_interceptor.dart';

part 'documentos_eletronicos_service.g.dart';

final BaseOptions option = BaseOptions(
  connectTimeout: const Duration(seconds: 50000),
  contentType: 'application/json',
);

@RestApi(baseUrl: NuvemFiscalConfig.apiUrl)
abstract class DocumentosEletronicosService {
  factory DocumentosEletronicosService(
    Dio dio, {
    String baseUrl,
  }) = _DocumentosEletronicosService;

  static DocumentosEletronicosService create({
    required Dio dio,
  }) {
    final dio = Dio();
    dio.options = option;
    dio.interceptors.add(DocumentosEletronicosInterceptor());
    return DocumentosEletronicosService(dio);
  }

  //{{baseUrl}}/cnpj/:Cnpj
  @GET('/cnpj/{Cnpj}')
  Future<String> cnpj({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('Cnpj') required String cnpj,
  });

  //{{baseUrl}}/cep/29165827
  @GET('/cep/{cep}')
  Future<String> cep({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('cep') required String cep,
  });

  //{{baseUrl}}/empresas?cpf_cnpj=14063822000126
  @GET('/empresas')
  Future<String> empresaListarEmpresas({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Query('\$top') int? top,
    @Query('\$skip') int? skip,
    @Query('\$inlinecount') bool? inlinecount,
    @Query('cpf_cnpj') String? cnpjCpf,
  });

  //{{baseUrl}}/empresas/:cpf_cnpj
  @GET('/empresas/{cpf_cnpj}')
  Future<String> empresaCpfCnpjConsultarEmpresa({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('cpf_cnpj') required String cnpjCpf,
  });

  //empresas/{cpf_cnpj}/nfce
  @GET('/empresas/{cpf_cnpj}/nfce')
  Future<String> empresaCpfCnpjNfceConsultarConfiguracao({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('cpf_cnpj') required String cnpjCpf,
  });

  //empresas/:cpf_cnpj/nfce
  @PUT('/empresas/{cpf_cnpj}/nfce')
  Future<String> empresaCpfCnpjNfceSalvarConfiguracao({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('cpf_cnpj') required String cnpjCpf,
    @Body() required String body,
  });

  //{{baseUrl}}/nfce?$top=100&$skip=0&$inlinecount=false&cpf_cnpj=14063822000126&ambiente=homologacao
  @GET('/nfce')
  Future<String> nfceListarNotasFiscais({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Query('\$top') int? top,
    @Query('\$skip') int? skip,
    @Query('\$inlinecount') bool? inlinecount,
    @Query('cpf_cnpj') String? cnpjCpf,
    @Query('ambiente') String? ambiente,
  });

  //{{baseUrl}}/nfce/sefaz/status?cpf_cnpj=14063822000126
  @GET('/nfce/sefaz/status')
  Future<String> nfceConsultarStatusSefaz({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Query('cpf_cnpj') required String cnpjCpf,
  });

  //{{baseUrl}}/nfce
  @POST('/nfce')
  Future<String> nfceEmitirNotaFiscal({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') String? authorization,
    @Body() String? body,
  });

  //{{baseUrl}}/nfce/:id
  @GET('/nfce/{id}')
  Future<String> nfceConsultarNotaFiscal({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/:id/xml
  @GET('/nfce/{id}/xml')
  Future<String> nfceBaixarXml({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/:id/pdf
  @GET('/nfce/{id}/pdf')
  Future<String> nfceBaixarPdf({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/:id/escpos
  @GET('/nfce/{id}/escpos')
  Future<String> nfceBaixarEscpos({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
    @Query('modelo') int modelo = 0,
    @Query('colunas') int colunas = 30,
  });

  //{{baseUrl}}/nfce/:id/cancelamento
  @POST('/nfce/{id}/cancelamento')
  Future<String> nfceCancelarNotaFiscal({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
    @Body() required String body,
  });

  //{{baseUrl}}/nfce/:id/cancelamento
  @GET('/nfce/{id}/cancelamento')
  Future<String> nfceConsultarCancelamento({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/:id/cancelamento/xml
  @GET('/nfce/{id}/cancelamento/xml')
  Future<String> nfceBaixarXmlCancelamento({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/:id/cancelamento/pdf
  @GET('/nfce/{id}/cancelamento/pdf')
  Future<String> nfceBaixarPdfCancelamento({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Path('id') required String id,
  });

  //{{baseUrl}}/nfce/inutilizacoes
  @POST('/nfce/inutilizacoes')
  Future<String> nfceInutilizarNumeracao({
    @Header('Accept') String? accept = 'application/json',
    @Header('Authorization') required String authorization,
    @Body() required String body,
  });
}
