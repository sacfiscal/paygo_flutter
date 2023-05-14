import 'package:get/get.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/service/paygo_sqlite_service.dart';

Future<String> obterSerieNfce() async {
  try {
    PayGoSqliteService payGoSqliteService = Get.find<PayGoSqliteService>();
    List<Map<String, dynamic>> rawQuery =
        await payGoSqliteService.database.rawQuery('select serieNfce from configuracoes');
    return rawQuery[0]['serieNfce'];
  } catch (e) {
    return '0';
  }
}

Future<int> obterUltimaNFCeConfing() async {
  try {
    PayGoSqliteService payGoSqliteService = Get.find<PayGoSqliteService>();
    List<Map<String, dynamic>> rawQuery =
        await payGoSqliteService.database.rawQuery('select ultimaNfce from configuracoes');
    return rawQuery[0]['ultimaNfce'];
  } catch (e) {
    return 0;
  }
}

Future<int> obterUltimaNfceConfingDocumento() async {
  try {
    PayGoSqliteService payGoSqliteService = Get.find<PayGoSqliteService>();
    List<Map<String, dynamic>> rawQuery =
        await payGoSqliteService.database.rawQuery('select max(nNF) as ultimaNfce from documentoNfce');
    return rawQuery[0]['ultimaNfce'];
  } catch (e) {
    return 0;
  }
}

Future<int> obterUltimaNfceInutilizacao() async {
  try {
    PayGoSqliteService payGoSqliteService = Get.find<PayGoSqliteService>();
    List<Map<String, dynamic>> rawQuery =
        await payGoSqliteService.database.rawQuery('select max(numeroFinal) as ultimaNfce from inutilizacao');
    return rawQuery[0]['ultimaNfce'];
  } catch (e) {
    return 0;
  }
}

Future<int> obterUltimaNfce() async {
  int numeracaoDoConfig = await obterUltimaNFCeConfing();
  int numericaoDoDocumento = await obterUltimaNfceConfingDocumento();
  int ultimaNfce = (numericaoDoDocumento > numeracaoDoConfig) ? numericaoDoDocumento : numeracaoDoConfig;
  return ultimaNfce;
}

Future<int> obterProximaNumeracaoNfce() async {
  int numeracaoDoConfig = await obterUltimaNFCeConfing();
  int numeracaoDoDocumento = await obterUltimaNfceConfingDocumento();
  int numeracaoInutilizacao = await obterUltimaNfceInutilizacao();
  List<int> numeros = [numeracaoDoConfig, numeracaoDoDocumento, numeracaoInutilizacao];
  int ultimaNfce = numeros.reduce((a, b) => a > b ? a : b);
  return ultimaNfce + 1;
}

Future<String> identificacaoDestinatario(int destinatarioId) async {
  try {
    PayGoSqliteService payGoSqliteService = Get.find<PayGoSqliteService>();
    List<Map<String, dynamic>> rawQuery =
        await payGoSqliteService.database.rawQuery('select nomeFantasia from destinatario where id = $destinatarioId');
    return rawQuery[0]['nomeFantasia'];
  } catch (e) {
    return '';
  }
}

Future<Map<String, dynamic>> obterStatusPagamento(int documentoId) async {
  PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
  DocumentoNfcePagamentoEntity? documentoNfcePagamentoEntity;
  documentoNfcePagamentoEntity = await paygoDatabaseRepository.documentoNFCePagamento.listarPorIdDocumento(
    documentoId,
  );
  var retorno = '${documentoNfcePagamentoEntity!.resultMessage}';
  if (documentoNfcePagamentoEntity.transactionResult != '0') {
    retorno = 'Erro: ${documentoNfcePagamentoEntity.transactionResult} - ${documentoNfcePagamentoEntity.resultMessage}';
  }
  return {
    'retorno': retorno,
    'transactionResult': documentoNfcePagamentoEntity.transactionResult,
    'resultMessage': documentoNfcePagamentoEntity.resultMessage,
  };
}

Future<void> totalizarVenda(int documentoId) async {
  try {
    PayGoSqliteService service = Get.find<PayGoSqliteService>();

    List<Map<String, dynamic>> rawQuery = await service.database.rawQuery('''
           select sum(vProd) as vProd,
                  sum(vFrete) as vFrete,
                  sum(vSeg) as vSeg,
                  sum(vDesc) as vDesc,
                  sum(vOutro) as vOutro
             from documentoNfceItem 
            where documentoId = $documentoId
        ''');

    double vProd = 0;
    double vFrete = 0;
    double vSeg = 0;
    double vDesc = 0;
    double vOutro = 0;

    double vNF = 0;

    try {
      vProd = rawQuery[0]['vProd'];
    } catch (e) {
      vProd = 0;
    }

    try {
      vFrete = rawQuery[0]['vFrete'];
    } catch (e) {
      vFrete = 0;
    }

    try {
      vSeg = rawQuery[0]['vSeg'];
    } catch (e) {
      vSeg = 0;
    }

    try {
      vDesc = rawQuery[0]['vDesc'];
    } catch (e) {
      vDesc = 0;
    }

    try {
      vOutro = rawQuery[0]['vOutro'];
    } catch (e) {
      vOutro = 0;
    }

    try {
      vNF = vProd + vFrete + vSeg + vOutro - vDesc;
    } catch (e) {
      vNF = 0;
    }

    await service.database.rawQuery('''
          update documentoNfce 
             set vProd = $vProd,
                 vFrete = $vFrete,
                 vSeg = $vSeg,
                 vDesc = $vDesc,
                 vOutro = $vOutro,
                  vNF = $vNF
           where id = $documentoId
    ''');
  } catch (e) {
    return;
  }
}
