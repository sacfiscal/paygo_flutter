import 'dart:async';
import 'dart:io';
import 'package:diacritic/diacritic.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform/flutter_pos_printer_platform.dart';
import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/presentation/views/venda/venda_controller.dart';
import 'package:paygo_sdk/paygo_sdk.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:receive_intent/receive_intent.dart' as receive_intent;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../commons/style/application_colors.dart';
import '../../domain/models/application/bluetooth_printer.dart';
import '../../domain/models/application/printer_device_model.dart';
import '../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';
import '../../infrastructure/services/elgin/elgin_m10_printer_service.dart';

class ApplicationController extends GetxController {
  late StreamSubscription _subscription;
  get subscription => _subscription;

  final _transacaoDocumentoId = 0.obs;

  final FlutterScanBluetooth _bluetooth = FlutterScanBluetooth();

  final _impressoras = ''.obs;
  final _listPrinterDevice = [].obs;
  final _scanning = false.obs;

  get impressoras => _impressoras.value;
  set impressoras(value) => _impressoras.value = value;

  get listPrinterDevice => _listPrinterDevice;
  set listPrinterDevice(value) => _listPrinterDevice.value = value;

  get scanning => _scanning.value;
  set scanning(value) => _scanning.value = value;

  TransacaoRequisicaoResposta? _requisicaoResposta;

  get transacaoDocumentoId => _transacaoDocumentoId.value;
  set transacaoDocumentoId(value) => _transacaoDocumentoId.value = value;

  TransacaoRequisicaoResposta? get requisicaoResposta => _requisicaoResposta;
  set requisicaoResposta(value) => _requisicaoResposta = value;

  Future<void> _initReceiveIntent() async {
    _subscription = receive_intent.ReceiveIntent.receivedIntentStream.listen(
      (
        receive_intent.Intent? intent,
      ) async {
        if (intent?.data != null) {
          final Uri uri = Uri.parse(intent?.data ?? '');

          final String decodedUri = Uri.decodeFull(
            uri.toString(),
          );

          requisicaoResposta = TransacaoRequisicaoResposta.fromUri(
            decodedUri,
          );

          if (requisicaoResposta?.operation == 'VERSAO') {
            await Get.defaultDialog(
              title: 'Versão',
              titleStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ApplicationColors.paygoYellow,
              ),
              contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
              backgroundColor: ApplicationColors.paygoDark,
              content: Column(
                children: [
                  Text(
                    requisicaoResposta!.resultMessage,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                  Text(
                    'ID: ${requisicaoResposta!.confirmationTransactionId}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                ],
              ),
              buttonColor: ApplicationColors.paygoYellow,
              confirmTextColor: ApplicationColors.paygoDark,
              confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ApplicationColors.paygoDark,
                  ),
                ),
              ),
            );
          }

          if (requisicaoResposta?.operation == 'CANCELAMENTO') {
            await Get.defaultDialog(
              title: 'Cancelamento',
              titleStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ApplicationColors.paygoYellow,
              ),
              contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
              backgroundColor: ApplicationColors.paygoDark,
              content: Column(
                children: [
                  Text(
                    requisicaoResposta!.resultMessage,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                  Text(
                    'ID: ${requisicaoResposta!.confirmationTransactionId}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                ],
              ),
              buttonColor: ApplicationColors.paygoYellow,
              confirmTextColor: ApplicationColors.paygoDark,
              confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ApplicationColors.paygoDark,
                  ),
                ),
              ),
            );
          }

          if (requisicaoResposta?.operation == 'EXIBE_PDC') {
            await Get.defaultDialog(
              title: 'Código do PDC',
              titleStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ApplicationColors.paygoYellow,
              ),
              contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
              backgroundColor: ApplicationColors.paygoDark,
              content: Column(
                children: [
                  Text(
                    requisicaoResposta!.resultMessage,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                  Text(
                    'ID: ${requisicaoResposta!.confirmationTransactionId}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                ],
              ),
              buttonColor: ApplicationColors.paygoYellow,
              confirmTextColor: ApplicationColors.paygoDark,
              confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ApplicationColors.paygoDark,
                  ),
                ),
              ),
            );
          }

          if ((requisicaoResposta?.operation == 'OPERACAO_DESCONHECIDA') &&
              (requisicaoResposta?.resultMessage == 'Teste ok')) {
            await Get.defaultDialog(
              title: 'Teste de Configuração',
              titleStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ApplicationColors.paygoYellow,
              ),
              contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
              backgroundColor: ApplicationColors.paygoDark,
              content: Column(
                children: [
                  Text(
                    'Terminal Integrado',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                  Text(
                    'ID: ${requisicaoResposta!.confirmationTransactionId}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ApplicationColors.paygoYellow,
                    ),
                  ),
                ],
              ),
              buttonColor: ApplicationColors.paygoYellow,
              confirmTextColor: ApplicationColors.paygoDark,
              confirm: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color: ApplicationColors.paygoDark,
                  ),
                ),
              ),
            );
          }

          // Retorno de Pagamento

          if (requisicaoResposta?.operation == 'VENDA') {
            if (transacaoDocumentoId != 0) {
              transacaoDocumentoId = 0;

              VendaController controller = Get.find<VendaController>();

              String ammount = requisicaoResposta!.amount;

              if (ammount == '') {
                ammount = '0';
              }

              double ammountValue = (double.parse(ammount) / 100);

              if (ammountValue.ceil() == controller.venda.value.vNF!.ceil()) {
                controller.venda.update(
                  (val) {
                    val?.situacao = 1;
                  },
                );

                int? indPag = 1;
                String? tPag = '';
                double? vPag = 0;
                String? descricaoPagamento = '';
                int? tpIntegra = 2;
                int? tBand = 99;

                if (requisicaoResposta?.finType == 'A_VISTA') {
                  indPag = 0;
                } else {
                  indPag = 1;
                }

                switch (requisicaoResposta?.cardType) {
                  case 'CARTAO_CREDITO':
                    tPag = '03';
                    break;
                  case 'CARTAO_DEBITO':
                    tPag = '04';
                    break;
                  case 'CARTAO_FROTA':
                    tPag = '13';
                    break;
                  case 'CARTAO_VOUCHER':
                    tPag = '99';
                    break;
                  default:
                    tPag = '99';
                    break;
                }

                vPag = ammountValue;

                switch (requisicaoResposta?.cardType) {
                  case 'CARTAO_CREDITO':
                    descricaoPagamento = 'Cartão de Crédito';
                    break;
                  case 'CARTAO_DEBITO':
                    descricaoPagamento = 'Cartão de Débito';
                    break;
                  case 'CARTAO_FROTA':
                    descricaoPagamento = 'Cartão de Frota';
                    break;
                  case 'CARTAO_VOUCHER':
                    descricaoPagamento = 'Cartão Voucher';
                    break;
                  default:
                    descricaoPagamento = 'Cartão Voucher';
                    break;
                }

                PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();
                repository.documentoNFCePagamento.insert(
                  DocumentoNfcePagamentoEntity(
                    documentoId: controller.venda.value.id,
                    emitenteId: controller.venda.value.emitenteId,
                    indPag: indPag,
                    tPag: tPag,
                    vPag: vPag,
                    descricaoPagamento: descricaoPagamento,
                    tpIntegra: tpIntegra,
                    tBand: tBand,
                    transactionResult: requisicaoResposta!.transactionResult,
                    cAut: requisicaoResposta!.authorizationCode,
                    amount: ammount,
                    installments: int.tryParse(requisicaoResposta!.installments),
                    currencyCode: requisicaoResposta!.currencyCode,
                    requiresConfirmation: requisicaoResposta!.requiresConfirmation,
                    confirmationTransactionId: requisicaoResposta!.confirmationTransactionId,
                    transactionNsu: requisicaoResposta!.transactionNsu,
                    authorizationCode: requisicaoResposta!.authorizationCode,
                    transactionId: requisicaoResposta!.transactionId,
                    providerName: requisicaoResposta!.providerName,
                    cardType: requisicaoResposta!.cardType,
                    maskedPan: requisicaoResposta!.maskedPan,
                    cardName: requisicaoResposta!.cardName,
                    defaultCardName: requisicaoResposta!.defaultCardName,
                    resultMessage: requisicaoResposta!.resultMessage,
                    merchantReceipt: requisicaoResposta!.merchantReceipt,
                    cardholderReceipt: requisicaoResposta!.cardholderReceipt,
                    shortReceipt: requisicaoResposta!.shortReceipt,
                    graphicReceiptExists: requisicaoResposta!.graphicReceiptExists,
                    merchantGraphicReceipt: requisicaoResposta!.merchantGraphicReceipt,
                    cardholderGraphicReceipt: requisicaoResposta!.cardholderGraphicReceipt,
                    paymentMode: requisicaoResposta!.paymentMode,
                    uniqueId: requisicaoResposta!.uniqueId,
                  ),
                );

                await controller.salvarVenda(
                  documentoId: controller.venda.value.id!,
                );

                if ((Get.find<ConfiguracoesSharedModel>().impressora?.name!.trim() != '') ||
                    (Get.find<ConfiguracoesSharedModel>().impressora?.tipoImpressora == '01')) {
                  try {
                    await imprimir(requisicaoResposta!.merchantReceipt);

                    await Get.dialog(
                      AlertDialog(
                        title: Text(
                          'Comprovante',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: ApplicationColors.paygoYellow,
                          ),
                        ),
                        content: Text(
                          'Deseja imprimir a via do cliente?',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: ApplicationColors.paygoYellow,
                          ),
                        ),
                        elevation: 2,
                        actionsAlignment: MainAxisAlignment.center,
                        buttonPadding: EdgeInsets.all(3),
                        shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          1,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
                        backgroundColor: ApplicationColors.paygoDark,
                        titleTextStyle: TextStyle(
                          color: ApplicationColors.paygoYellow,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              Get.back();
                            },
                            child: Text(
                              'Não',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ApplicationColors.paygoYellow,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await imprimir(requisicaoResposta!.cardholderReceipt);
                              Get.back();
                            },
                            child: Text(
                              'Sim',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } catch (e) {
                    loggerNoStack.e(e);
                  }
                }

                controller.encerrarPagamento();
              }
            }
          }

          loggerNoStack.i(
            "Intent Data: ${requisicaoResposta?.toMap()}",
          );
        }
      },
      onError: (err) {
        loggerNoStack.e("Erro ao receber Intent");
      },
    );
  }

  Future<void> listarImpressoras() async {
    _bluetooth.startScan();
  }

  String normalizeString(
    String text, {
    List<String> charactersToReplace = const ["á", "é", "í", "ó", "ú", "ç"],
    List<String> replacementCharacters = const ["a", "e", "i", "o", "u", "c"],
  }) {
    // Remove os diacríticos do texto
    String normalized = removeDiacritics(text);

    // Substitui os caracteres especiais
    for (int i = 0; i < charactersToReplace.length; i++) {
      normalized = normalized.replaceAll(charactersToReplace[i], replacementCharacters[i]);
    }

    return normalized;
  }

  Future<void> imprimirTeste() async {
    if (Get.find<ConfiguracoesSharedModel>().impressora?.tipoImpressora == '02') {
      List<int> bytes = [];

      // Xprinter XP-N160I
      final profile = await CapabilityProfile.load(name: 'XP-N160I');

      // PaperSize.mm80 or PaperSize.mm58
      final generator = Generator(PaperSize.mm58, profile);

      bytes += generator.setGlobalCodeTable('CP1252');

      var printerManager = PrinterManager.instance;

      var device = BluetoothPrinter(
        deviceName: Get.find<ConfiguracoesSharedModel>().impressora?.name,
        address: Get.find<ConfiguracoesSharedModel>().impressora?.address,
        port: '9100',
        typePrinter: PrinterType.bluetooth,
        state: false,
      );

      bytes += generator.cut();

      await printerManager.connect(
        type: device.typePrinter,
        model: BluetoothPrinterInput(
          name: device.deviceName,
          address: device.address!,
          isBle: false,
          autoConnect: true,
        ),
      );

      bytes += generator.text(
        'PayGO',
        styles: const PosStyles(
          reverse: false,
          bold: false,
          fontType: PosFontType.fontA,
          height: PosTextSize.size2,
          turn90: false,
          underline: false,
          width: PosTextSize.size2,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Exemplo PDV Flutter',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontA,
          height: PosTextSize.size1,
          turn90: false,
          underline: false,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        '- - - - - - - - - - - - - -',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontA,
          height: PosTextSize.size1,
          turn90: false,
          underline: false,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Teste de Impressao',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontB,
          height: PosTextSize.size1,
          turn90: false,
          underline: false,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Fonte A - S1',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontA,
          height: PosTextSize.size1,
          turn90: false,
          underline: false,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Fonte A - S2',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontA,
          height: PosTextSize.size2,
          turn90: false,
          underline: false,
          width: PosTextSize.size2,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Fonte B - S1',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontB,
          height: PosTextSize.size1,
          turn90: false,
          underline: false,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ),
        linesAfter: 0,
      );

      bytes += generator.text(
        'Fonte B - S2',
        styles: const PosStyles(
          reverse: false,
          bold: true,
          fontType: PosFontType.fontB,
          height: PosTextSize.size2,
          turn90: false,
          underline: false,
          width: PosTextSize.size2,
          align: PosAlign.center,
        ),
        linesAfter: 1,
      );

      bytes += generator.text(
        'br.com.claydneysessa',
        styles: const PosStyles(
          align: PosAlign.center,
        ),
        linesAfter: 1,
      );

      bytes += generator.qrcode(
        'br.com.claydneysessa',
        size: QRSize.Size8,
      );

      bytes += generator.cut();

      printerManager.send(
        type: device.typePrinter,
        bytes: bytes,
      );

      printerManager.disconnect(
        type: device.typePrinter,
      );
    } else {
      ElginM10PrinterService elginM10PrinterService = ElginM10PrinterService();
      await elginM10PrinterService.abrirConexaoInterna();

      try {
        await elginM10PrinterService.imprimirTexto(
          text: 'PAYGO',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 16,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'Exemplo PDV Flutter',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 1,
        );
        await elginM10PrinterService.imprimirTexto(
          text: '- - - - - - - - - - - - - -',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 2,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'Teste de Impressão',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 1,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT A - S1',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 1,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT A - S2',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 2,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT A - S3',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 3,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT A - S4',
          align: 'Centralizado',
          font: 'FONT A',
          fontSize: 4,
        );

        await elginM10PrinterService.imprimirTexto(
          text: 'FONT B - S1',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 1,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT B - S2',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 2,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT B - S3',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 3,
        );
        await elginM10PrinterService.imprimirTexto(
          text: 'FONT B - S4',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 4,
        );

        await elginM10PrinterService.avancarLinhas(6);

        await elginM10PrinterService.imprimirTexto(
          text: 'br.com.claydneysessa',
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 1,
        );

        await elginM10PrinterService.avancarLinhas(6);

        await elginM10PrinterService.imprimirQRCode(
          qrSize: 4,
          text: 'br.com.claydneysessa',
          align: 'Centralizado',
        );

        await elginM10PrinterService.avancarLinhas(10);

        await elginM10PrinterService.cortarPapel(10);
      } finally {
        await elginM10PrinterService.fecharConexao();
      }
    }
  }

  Future<void> imprimir(String texto) async {
    if (Get.find<ConfiguracoesSharedModel>().impressora?.tipoImpressora == '02') {
      List<int> bytes = [];

      // Xprinter XP-N160I
      final profile = await CapabilityProfile.load(name: 'XP-N160I');

      // PaperSize.mm80 or PaperSize.mm58
      final generator = Generator(PaperSize.mm58, profile);

      bytes += generator.setGlobalCodeTable('CP1252');

      var printerManager = PrinterManager.instance;

      var device = BluetoothPrinter(
        deviceName: Get.find<ConfiguracoesSharedModel>().impressora?.name,
        address: Get.find<ConfiguracoesSharedModel>().impressora?.address,
        port: '9100',
        typePrinter: PrinterType.bluetooth,
        state: false,
      );

      bytes += generator.cut();

      await printerManager.connect(
        type: device.typePrinter,
        model: BluetoothPrinterInput(
          name: device.deviceName,
          address: device.address!,
          isBle: false,
          autoConnect: true,
        ),
      );

      RegExp regex = RegExp(r'http.+');

      String linhaHttp = '';

      texto.split('\n').forEach((linha) {
        if (regex.hasMatch(linha)) {
          linhaHttp = linha;
        }
      });

      if (linhaHttp.trim() != '') {
        texto.replaceAll(linhaHttp, '');
      }

      bytes += generator.text(
        texto,
        styles: const PosStyles(
          fontType: PosFontType.fontA,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ),
        linesAfter: 1,
      );

      if (linhaHttp.trim() != '') {
        String qrData = linhaHttp.trim();
        const double qrSize = 200;
        try {
          final uiImg = await QrPainter(
            data: qrData,
            version: QrVersions.auto,
            gapless: false,
          ).toImageData(qrSize);
          final dir = await getTemporaryDirectory();
          final pathName = '${dir.path}/qr_tmp.png';
          final qrFile = File(pathName);
          final imgFile = await qrFile.writeAsBytes(uiImg!.buffer.asUint8List());
          final img = decodeImage(imgFile.readAsBytesSync());

          bytes += generator.image(img!);
        } catch (e) {
          loggerNoStack.e(e);
        }
      }

      bytes += generator.cut();

      printerManager.send(
        type: device.typePrinter,
        bytes: bytes,
      );

      printerManager.disconnect(
        type: device.typePrinter,
      );
    } else {
      ElginM10PrinterService elginM10PrinterService = ElginM10PrinterService();
      await elginM10PrinterService.abrirConexaoInterna();

      RegExp regex = RegExp(r'http.+');
      String linhaHttp = '';

      texto.split('\n').forEach((linha) {
        if (regex.hasMatch(linha)) {
          linhaHttp = linha;
        }
      });

      if (linhaHttp.trim() != '') {
        texto.replaceAll(linhaHttp, '');
      }

      try {
        await elginM10PrinterService.imprimirTexto(
          text: texto,
          align: 'Centralizado',
          font: 'FONT B',
          fontSize: 1,
        );

        if (linhaHttp.trim() != '') {
          try {
            await elginM10PrinterService.imprimirQRCode(
              qrSize: 4,
              text: linhaHttp,
              align: 'Centralizado',
            );
          } catch (e) {
            loggerNoStack.e(e);
          }
        }

        await elginM10PrinterService.avancarLinhas(6);

        await elginM10PrinterService.cortarPapel(6);
      } finally {
        await elginM10PrinterService.fecharConexao();
      }
    }
  }

  Future<void> administrativoclick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.administrativo();
  }

  Future<void> configuracaoClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.configuracao,
      ),
    );
  }

  Future<void> manutencaoClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.manutencao,
      ),
    );
  }

  Future<void> instalacaoClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.instalacao,
      ),
    );
  }

  Future<void> versaoClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.versao,
      ),
    );
  }

  Future<void> testeComunicacaoClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.testeComunicacao,
      ),
    );
  }

  Future<void> exibirPdcClick() async {
    PayGOSdk repository = PayGOSdk();
    await repository.integrado.generico(
      TransacaoRequisicaoGenerica(
        operation: Operation.exibePdc,
      ),
    );
  }

  Future<void> solicitarPagamentoClick({
    required int documentoId,
    required double valor,
  }) async {
    PayGOSdk repository = PayGOSdk();

    transacaoDocumentoId = documentoId;

    await repository.integrado.venda(
      TransacaoRequisicaoVenda(
        amount: valor,
        currencyCode: CurrencyCode.iso4217Real,
      ),
    );
  }

  Future<void> solicitarPagamentoDinheiroClick({
    required int documentoId,
    required double valor,
  }) async {
    VendaController controller = Get.find<VendaController>();

    PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();

    controller.venda.update((val) {
      val?.situacao = 2;
    });

    repository.documentoNFCePagamento.insert(
      DocumentoNfcePagamentoEntity(
        documentoId: controller.venda.value.id,
        emitenteId: controller.venda.value.emitenteId,
        indPag: 0,
        tPag: '01',
        vPag: valor,
        descricaoPagamento: 'Pagamento em Dinheiro',
        installments: 0,
      ),
    );

    controller.salvarVenda(
      documentoId: controller.venda.value.id!,
    );

    controller.encerrarPagamento();
  }

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  var loggerNoStack = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  @override
  void onInit() async {
    await _initReceiveIntent();

    super.onInit();

    _bluetooth.devices.listen(
      (device) {
        PrinterDeviceModel impressora = PrinterDeviceModel(
          name: device.name,
          address: device.address,
        );

        if (listPrinterDevice.contains(impressora) == false) {
          listPrinterDevice.add(impressora);
        }
      },
    );

    _bluetooth.scanStopped.listen(
      (device) {
        scanning = false;
        impressoras += 'scan stopped\n';
      },
    );

    _bluetooth.startScan();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
