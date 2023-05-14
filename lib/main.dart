import 'dart:io';
import 'package:dio/dio.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'commons/constantes/nuvem_fiscal_config.dart';
import 'commons/constantes/paygo_config.dart';
import 'domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import 'infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'infrastructure/repositories/shared_preferences/configuracoes_repository.dart';
import 'infrastructure/services/api/nuvem_fiscal/autenticacao/service/autenticacao_interceprot.dart';
import 'infrastructure/services/api/nuvem_fiscal/autenticacao/service/autenticacao_service.dart';
import 'infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/service/documentos_eletronicos_interceptor.dart';
import 'infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/service/documentos_eletronicos_service.dart';
import 'infrastructure/services/database/paygo_sqlite/service/paygo_sqlite_service.dart';
import 'presentation/application/application_widget.dart';

void main() async {
  /* Permitindo que a aplicação aguarde a inicialização das dependências */
  WidgetsFlutterBinding.ensureInitialized();

  /* Definindo a orientação da tela como retrato */
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );

  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: ApplicationColors.paygoDark, // define a cor da barra de status
    ),
  );

  /* Iniciando as dependências */
  init().then(
    (value) => /* Iniciando a aplicação */
        runApp(
      const ApplicationWidget(),
    ),
  );
}

Future<void> init() async {
  Get.put<RouteObserver>(
    RouteObserver<PageRoute>(),
    permanent: true,
  );

  /* Iniciando o Logger */
  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      printTime: true,
      noBoxingByDefault: false,
    ),
  );

  /* Incluindo o logger como um objeto global */
  Get.put<Logger>(
    logger,
    permanent: true,
  );

  /* Incluindo o reposiório de configurações como um objeto global */
  Get.create<ConfiguracoesRepository>(
    () {
      var repository = ConfiguracoesRepository();
      return repository;
    },
    permanent: true,
  );

  /* Iniciando o modelo de configurações */
  ConfiguracoesSharedModel configuracoesModel = await Get.find<ConfiguracoesRepository>().getConfiguration();

  /* Atualizando a data de último acesso */
  configuracoesModel.dataUltimoAcesso = DateTime.now();
  Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

  /* Incluindo o modelo de configurações como um objeto global */
  Get.put<ConfiguracoesSharedModel>(
    configuracoesModel,
    permanent: true,
  );

  /* Instanciando o Callbak para monitorar o banco de dados */
  final callback = Callback(
    onCreate: (database, version) {
      /* Log de Criação */
      Get.find<Logger>().i('Criação do banco de dados realizada com sucesso!');
    },
    onOpen: (database) async {
      /* Log de Abertura */
      Get.find<Logger>().i('Banco de dados Iniciado com sucesso!');
    },
    onUpgrade: (database, startVersion, endVersion) {
      /* Log de Upgrade */
      Get.find<Logger>().i('Atualização do banco de dados realizada com sucesso!');
    },
  );

  /* Iniciando o Serviço de Banco de Dados */
  PayGoSqliteService payGoSqliteService =
      await $FloorPayGoSqliteService.databaseBuilder(PaygoConfig.databaseName).addCallback(callback).build();

  /* Incluindo o serviço de banco de dados como um objeto global */
  Get.put<PayGoSqliteService>(
    payGoSqliteService,
    permanent: true,
  );

  /* Iniciando o service de autenticação da API */
  Get.create<AutenticacaoService>(
    () {
      var repository = AutenticacaoService(
        Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 30000),
          ),
        )..interceptors.add(AutenticacaoInerceptor()),
        baseUrl: NuvemFiscalConfig.accessTokenUrl,
      );
      return repository;
    },
    permanent: false,
  );

  /* Iniciando o service de integração da API */
  Get.create<DocumentosEletronicosService>(
    () {
      var repository = DocumentosEletronicosService(
        Dio(
          BaseOptions(
            connectTimeout: const Duration(seconds: 30000),
          ),
        )..interceptors.add(DocumentosEletronicosInterceptor()),
        baseUrl: NuvemFiscalConfig.apiUrl,
      );
      return repository;
    },
    permanent: false,
  );

  /* Incluindo o reposiório de Integração como um objeto global */
  Get.create<DocumentosEletronicosRepository>(
    () {
      var repository = DocumentosEletronicosRepository();
      return repository;
    },
    permanent: true,
  );

  /* Incluindo o reposiório de Banco de Dados como um objeto global */
  Get.create<PaygoDatabaseRepository>(
    () {
      var repository = PaygoDatabaseRepository();
      return repository;
    },
    permanent: true,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}
