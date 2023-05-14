import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/inutilizacao_model.dart';
import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/configuracoes_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/emitente_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/inutilizacao_entity.dart';

import '../../../commons/types/ambiente.dart';
import '../../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_inutilizacao_dto.dart';

class InutilizacaoController extends GetxController {
  final _isLoading = false.obs;

  final _formKey = GlobalKey<FormState>();

  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;
  final _senhaVisivel = false.obs;

  final _inutilizacaoMsg = 'Documento fiscal não utilizado'.obs;

  final _serie = ''.obs;

  final inutilizacao = InutilizacaoModel().obs;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoadList => _isLoadList.value;
  set isLoadList(bool value) => _isLoadList.value = value;
  String get campoBusca => _campoBusca.value;
  set campoBusca(String value) => _campoBusca.value = value;
  bool get senhaVisivel => _senhaVisivel.value;
  set senhaVisivel(bool value) => _senhaVisivel.value = value;
  String get serie => _serie.value;
  set serie(String value) => _serie.value = value;

  String get inutilizacaoMsg => _inutilizacaoMsg.value;
  set inutilizacaoMsg(String value) => _inutilizacaoMsg.value = value;

  Rx<List<InutilizacaoModel>> list = Rx<List<InutilizacaoModel>>([]);

  Future<void> carregarLista() async {
    isLoadList = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<InutilizacaoEntity>? result = await paygoDatabaseRepository.inutilizacao.listar(
        obterAmbienteFromDisplay(Get.find<ConfiguracoesSharedModel>().ambiente!).value,
      );

      List<InutilizacaoModel> listAux = [];
      listAux.addAll(result!.map((e) => InutilizacaoModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.numeroInicial.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.numeroFinal.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    )));
          }),
        );
      } else {
        list.value.addAll(listAux);
      }
    } finally {
      isLoadList = false;
    }
  }

  Future<void> inutilizarSequencia() async {}

  void salvarRegistro() async {
    if (_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      DocumentosEletronicosRepository documentosEletronicosRepository = Get.find<DocumentosEletronicosRepository>();

      PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();

      EmitenteEntity? emitenteEntity = await repository.emitente.listarPorId(
        Get.find<ConfiguracoesSharedModel>().emitenteId!,
      );

      ConfiguracoesEntity? configuracoesEntity;
      configuracoesEntity = await paygoDatabaseRepository.configuracoes.listarPorId(1);

      RetornoInutilizacaoDto? retornoInutilizacaoDto = await documentosEletronicosRepository.nfce.inutilizarSequencia(
        justificativa: 'Pulo de sequencia de NFCe',
        numeroInicial: inutilizacao.value.numeroInicial!,
        numeroFinal: inutilizacao.value.numeroFinal!,
        serie: inutilizacao.value.serie!,
        ano: 2023,
        cnpj: emitenteEntity!.cnpjCpf!,
        ambiente: obterAmbienteDisplay(removeDiacritics(configuracoesEntity!.ambiente!.toLowerCase())).toLowerCase(),
      );

      InutilizacaoEntity? inutilizacaoEntity = InutilizacaoEntity.fromJson(inutilizacao.toJson());

      inutilizacaoEntity.protocoloInutilizacao = retornoInutilizacaoDto.numeroProtocolo;
      inutilizacaoEntity.dhInutilizacao = retornoInutilizacaoDto.dataRecebimento;
      inutilizacaoEntity.justificativa = 'Pulo de sequencia de NFCe';

      await repository.inutilizacao.update(inutilizacaoEntity);

      await carregarLista();

      Get.back();

      if (inutilizacaoEntity.id == null) {
        paygoDatabaseRepository.inutilizacao.insert(inutilizacaoEntity);
      } else {
        paygoDatabaseRepository.inutilizacao.update(inutilizacaoEntity);
      }
    }
  }

  @override
  void onInit() async {
    await carregarLista();

    PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();
    ConfiguracoesEntity? configuracoesEntity = await repository.configuracoes.listarPorId(1);
    serie = configuracoesEntity!.serieNfce!;

    super.onInit();
  }
}
