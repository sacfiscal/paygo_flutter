import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/types/tpag.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/forma_pagamento_model.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/forma_pagamento_entity.dart';

import '../../../commons/components/pesquisas/pesquisa.dart';
import '../../../commons/style/application_colors.dart';

class FormaPagamentoController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;

  final formaPagamento = FormaPagamentoModel().obs;

  Rx<List<FormaPagamentoModel>> list = Rx<List<FormaPagamentoModel>>([]);

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
      List<FormaPagamentoEntity>? result = await paygoDatabaseRepository.formaPagamento.listar();

      List<FormaPagamentoModel> listAux = [];
      listAux.addAll(result!.map((e) => FormaPagamentoModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.descricao.toString().toLowerCase().contains(
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

  Future<void> buscarTpag(var context) async {
    List<Tpag> listaOrigem = [
      Tpag.dinheiro,
      Tpag.cheque,
      Tpag.cartaoCredito,
      Tpag.cartaoDebito,
      Tpag.creditoLoja,
      Tpag.valeAlimentacao,
      Tpag.valeRefeicao,
      Tpag.valePresente,
      Tpag.valeCombustivel,
      Tpag.boletoBancario,
      Tpag.depositoBancario,
      Tpag.pagamentoInstantaneo,
      Tpag.transferenciaBancaria,
      Tpag.programaFidelidade,
      Tpag.semPagamento,
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

    formaPagamento.update(
      (campoUpdate) {
        campoUpdate!.codSefaz = resultadoBusca['value'].toString();
      },
    );
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
              FormaPagamentoEntity formaPagamentoEntity = FormaPagamentoEntity.fromJson(formaPagamento.toJson());
              paygoDatabaseRepository.formaPagamento.delete(formaPagamentoEntity);
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
    if (_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      FormaPagamentoEntity? formaPagamentoEntity = FormaPagamentoEntity.fromJson(formaPagamento.toJson());

      if (formaPagamentoEntity.id == null) {
        paygoDatabaseRepository.formaPagamento.insert(formaPagamentoEntity);
      } else {
        paygoDatabaseRepository.formaPagamento.update(formaPagamentoEntity);
      }

      formaPagamentoEntity = await paygoDatabaseRepository.formaPagamento.listarPorCodSefazDescricao(
        formaPagamento.value.codSefaz!,
        formaPagamento.value.descricao!,
      );

      formaPagamento.value = FormaPagamentoModel.fromJson(formaPagamentoEntity!.toJson());

      formaPagamento.update((val) {
        val!.id = formaPagamentoEntity!.id;
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
