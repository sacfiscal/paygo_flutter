import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/components/pesquisas/pesquisa.dart';
import 'package:paygo_app/commons/types/origem.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/produto_model.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/produto_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/unidade_medida_entity.dart';

import '../../../commons/style/application_colors.dart';
import '../../../commons/types/status.dart';
import '../../../infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';

class ProdutoController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;

  final produto = ProdutoModel().obs;

  Rx<List<ProdutoModel>> list = Rx<List<ProdutoModel>>([]);

  GlobalKey<FormState> get formKey => _formKey;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  get isLoadList => _isLoadList.value;
  set isLoadList(value) => _isLoadList.value = value;

  get campoBusca => _campoBusca.value;
  set campoBusca(value) => _campoBusca.value = value;

  Future<void> buscarStatus(var context) async {
    List<Status> listaOrigem = [
      Status.ativo,
      Status.inativo,
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

    produto.update(
      (campoUpdate) {
        campoUpdate!.ativo = (resultadoBusca['value'] == 1);
      },
    );
  }

  Future<void> carregarLista() async {
    isLoadList = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<ProdutoEntity>? result = await paygoDatabaseRepository.produto.listar();

      List<ProdutoModel> listAux = [];
      listAux.addAll(result!.map((e) => ProdutoModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.descricao.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.ncm.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.cean.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.cbarra.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.codigo.toString().toLowerCase().contains(
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

  Future<void> buscarUnidade(var context) async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
    List<UnidadeMedidaEntity>? unidades = await paygoDatabaseRepository.unidadeMedida.listar();

    Map<String, dynamic> resultadoBusca = await showSearch(
      context: context,
      delegate: PesquisaWidget(
        unidades!
            .map(
              (e) => {
                "display": e.descricao,
                "value": e.sigla,
              },
            )
            .toList(),
      ),
    );

    produto.update(
      (campoUpdate) {
        campoUpdate!.unidade = resultadoBusca['value'];
      },
    );
  }

  Future<void> buscarOrigem(var context) async {
    List<OrigemMercadoria> listaOrigem = [
      OrigemMercadoria.nacional,
      OrigemMercadoria.estrangeiraImportacaoDireta,
      OrigemMercadoria.estrangeiraAdquiridaMercadoInterno,
      OrigemMercadoria.nacionalConteudoImportacaoSuperior40,
      OrigemMercadoria.nacionalProducaoProcessosProdutivosBasicos,
      OrigemMercadoria.nacionalConteudoImportacaoInferior40,
      OrigemMercadoria.estrangeiraImportacaoDiretaSemSimilarNacional,
      OrigemMercadoria.estrangeiraAdquiridaMercadoInternoSemSimilarNacional,
      OrigemMercadoria.nacionalConteudoImportacaoSuperior70,
    ];

    Map<String, dynamic> resultadoBusca = await showSearch(
      context: context,
      delegate: PesquisaWidget(
        listaOrigem
            .map(
              (e) => {
                "display": e.origemMercadoriaString,
                "value": e.origemMercadoriaInt.toString(),
              },
            )
            .toList(),
      ),
    );

    produto.update(
      (campoUpdate) {
        campoUpdate!.origem = resultadoBusca['value'];
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
              ProdutoEntity produtoEntity = ProdutoEntity.fromJson(produto.toJson());
              paygoDatabaseRepository.produto.delete(produtoEntity);
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
    if (formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      ProdutoEntity? produtoEntity = ProdutoEntity.fromJson(produto.toJson());

      if (produtoEntity.id == null) {
        paygoDatabaseRepository.produto.insert(produtoEntity);
      } else {
        paygoDatabaseRepository.produto.update(produtoEntity);
      }

      produtoEntity = await paygoDatabaseRepository.produto.listarPorCodigo(
        int.parse(produto.value.codigo!),
      );

      produto.value = ProdutoModel.fromJson(produtoEntity!.toJson());

      Get.back();
    }
  }

  @override
  void onInit() async {
    await carregarLista();
    super.onInit();
  }
}
