import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/emitente_model.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/emitente_entity.dart';
import 'package:search_cep/search_cep.dart';
import 'package:dartz/dartz.dart';

import '../../../commons/components/pesquisas/pesquisa.dart';
import '../../../commons/types/crt.dart';

class EmpresaController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = true.obs;
  final _crt = ''.obs;
  final emitente = EmitenteModel().obs;

  GlobalKey<FormState> get formKey => _formKey;

  bool get isLoading => _isLoading.value;
  set isLoading(bool value) {
    _isLoading.value = value;
  }

  String get crt => _crt.value;
  set crt(String value) {
    _crt.value = value;
  }

  void setCrt(String crt) {
    emitente.value.crt = crt;
    _crt.value = crt;
  }

  void buscaCep() async {
    final viaCepSearchCep = ViaCepSearchCep();

    Either<SearchCepError, ViaCepInfo> infoCep = await viaCepSearchCep.searchInfoByCep(
      cep: emitente.value.cep!,
    );

    ViaCepInfo? cep;
    SearchCepError? error;

    infoCep.fold(
      (l) {
        return error = l;
      },
      (r) {
        return cep = r;
      },
    );

    if (error != null) {
      Get.snackbar(
        'Erro',
        error!.errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      if (cep != null) {
        emitente.update(
          (emitente) {
            emitente?.cep = cep?.cep;
            emitente?.logradouro = cep?.logradouro;
            emitente?.bairro = cep?.bairro;
            emitente?.municipio = cep?.localidade;
            emitente?.uf = cep?.uf;
            emitente?.codigoMunicipio = cep?.unidade;
          },
        );
      }
    }
  }

  Future<void> buscarCrt(var context) async {
    List<Crt> listaOrigem = [
      Crt.simplesNacional,
      Crt.simplesNacionalExcessoSublimite,
      Crt.regimeNormal,
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

    emitente.update(
      (campoUpdate) {
        campoUpdate!.crt = resultadoBusca['value'].toString();
      },
    );
  }

  void salvar() {
    if (_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      EmitenteEntity emitenteEntity = EmitenteEntity.fromJson(emitente.toJson());
      paygoDatabaseRepository.emitente.update(emitenteEntity);
      Get.back();
    }
  }

  @override
  void onInit() async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
    EmitenteEntity? emitenteEntity;

    paygoDatabaseRepository.emitente.listarPorId(1).then((value) {
      emitenteEntity = value;
      emitente.value = EmitenteModel.fromJson(emitenteEntity!.toJson());
      crt = emitente.value.crt!;
      isLoading = false;
    });

    super.onInit();
  }
}
