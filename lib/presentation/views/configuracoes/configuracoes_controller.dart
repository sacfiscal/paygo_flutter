import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/types/ambiente.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/configuracoes_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/emitente_entity.dart';
import 'package:paygo_app/presentation/views/home/home_controller.dart';

import '../../../commons/components/pesquisas/pesquisa.dart';
import '../../../domain/models/application/printer_device_model.dart';
import '../../../domain/models/databaase/paygo_sqlite/configuracoes_model.dart';
import '../../../domain/models/databaase/paygo_sqlite/emitente_model.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart' as shared;
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/shared_preferences/configuracoes_repository.dart';

class ConfiguracoesController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = true.obs;
  final _ambiente = ''.obs;
  final _impressora = ''.obs;

  final _selectedPrinter = '02'.obs;

  String get impressora => _impressora.value;
  set impressora(String value) => _impressora.value = value;

  final configuracao = ConfiguracoesModel().obs;
  final emitente = EmitenteModel().obs;

  String get selectedPrinter => _selectedPrinter.value;
  set selectedPrinter(String value) => _selectedPrinter.value = value;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
  }

  String get ambiente => _ambiente.value;
  set ambiente(String value) {
    _ambiente.value = value;
  }

  void setAmbiente(String ambiente) {
    configuracao.value.ambiente = ambiente;
    _ambiente.value = ambiente;
  }

  Future<void> buscarAmbiente(var context) async {
    List<Ambiente> listaOrigem = [
      Ambiente.producao,
      Ambiente.homologacao,
    ];

    Map<String, dynamic> resultadoBusca = await showSearch(
      context: context,
      delegate: PesquisaWidget(
        listaOrigem
            .map(
              (e) => {
                "display": e.display,
                "value": e.value,
              },
            )
            .toList(),
      ),
    );

    configuracao.update(
      (campoUpdate) {
        campoUpdate!.ambiente = resultadoBusca['value'].toString();
      },
    );
  }

  void salvar() {
    if (formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      ConfiguracoesEntity configuracoesEntity = ConfiguracoesEntity.fromJson(configuracao.toJson());
      paygoDatabaseRepository.configuracoes.update(configuracoesEntity);

      ConfiguracoesSharedModel configuracoesModel = Get.find<ConfiguracoesSharedModel>();

      var codigoAmbiente = obterAmbienteFromCode(configuracao.value.ambiente!);

      configuracoesModel.ambiente = codigoAmbiente.display;
      configuracoesModel.impressora?.tipoImpressora = selectedPrinter;

      Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);
      Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);

      Get.find<HomeController>().setAmbiente(configuracoesModel.ambiente!);

      Get.back();
    }
  }

  void limparImpressora() async {
    PrinterDeviceModel printer = PrinterDeviceModel();
    printer.name = '';
    printer.address = '';

    impressora = printer.name ?? '';

    ConfiguracoesSharedModel configuracoesModel = Get.find<ConfiguracoesSharedModel>();

    configuracoesModel.impressora = printer;

    Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
    await Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);
  }

  @override
  void onInit() async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
    ConfiguracoesEntity? configuracoesEntity;
    EmitenteEntity? emitenteEntity;

    impressora = Get.find<shared.ConfiguracoesSharedModel>().impressora?.name ?? '';
    selectedPrinter = Get.find<shared.ConfiguracoesSharedModel>().impressora?.tipoImpressora ?? '02';

    if (selectedPrinter.toString().trim() == '') {
      selectedPrinter = '02';
    }

    paygoDatabaseRepository.configuracoes.listarPorId(1).then((value) {
      configuracoesEntity = value;
      configuracao.value = ConfiguracoesModel.fromJson(configuracoesEntity!.toJson());
      ambiente = configuracao.value.ambiente!;
      isLoading = false;
    });

    paygoDatabaseRepository.emitente.listarPorId(1).then((value) {
      emitenteEntity = value;
      emitente.value = EmitenteModel.fromJson(emitenteEntity!.toJson());
    });

    super.onInit();
  }
}
