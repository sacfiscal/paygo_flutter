import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/unidade_medida_model.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/unidade_medida_entity.dart';

import '../../../commons/style/application_colors.dart';

class UnidadeController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;

  final unidade = UnidadeMedidaModel().obs;

  Rx<List<UnidadeMedidaModel>> list = Rx<List<UnidadeMedidaModel>>([]);

  GlobalKey<FormState> get formKey => _formKey;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  get isLoadList => _isLoadList.value;
  set isLoadList(value) => _isLoadList.value = value;

  get campoBusca => _campoBusca.value;
  set campoBusca(value) => _campoBusca.value = value;

  Future<void> carregarLista() async {
    isLoadList = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<UnidadeMedidaEntity>? result = await paygoDatabaseRepository.unidadeMedida.listar();

      List<UnidadeMedidaModel> listAux = [];
      listAux.addAll(result!.map((e) => UnidadeMedidaModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.descricao.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.sigla.toString().toLowerCase().contains(
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

  Future<void> excluirRegistro() async {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Excluir',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
        backgroundColor: ApplicationColors.paygoDark,
        titleTextStyle: TextStyle(
          color: ApplicationColors.paygoYellow,
        ),
        content: const Text(
          'Deseja realmente excluir o registro?',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Não',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ApplicationColors.paygoYellow,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
              UnidadeMedidaEntity unidadeMedidaEntity = UnidadeMedidaEntity.fromJson(unidade.toJson());
              paygoDatabaseRepository.unidadeMedida.delete(unidadeMedidaEntity);
              Get.back();
              Get.back();
            },
            child: const Text(
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
  }

  void salvarRegistro() async {
    if (!_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      UnidadeMedidaEntity? unidadeMedidaEntity = UnidadeMedidaEntity.fromJson(unidade.toJson());

      if (unidadeMedidaEntity.id == null) {
        paygoDatabaseRepository.unidadeMedida.insert(unidadeMedidaEntity);
      } else {
        paygoDatabaseRepository.unidadeMedida.update(unidadeMedidaEntity);
      }

      unidadeMedidaEntity = await paygoDatabaseRepository.unidadeMedida.listarPorSiglaDescricao(
        unidade.value.sigla!,
        unidade.value.descricao!,
      );

      unidade.value = UnidadeMedidaModel.fromJson(unidadeMedidaEntity!.toJson());

      unidade.update((val) {
        val!.id = unidadeMedidaEntity!.id;
      });

      Get.back();
    }
  }

  @override
  void onInit() async {
    await carregarLista();
    super.onInit();
  }
}
