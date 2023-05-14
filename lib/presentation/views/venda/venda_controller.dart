import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paygo_app/commons/functions/funcoes_database.dart';
import 'package:paygo_app/commons/types/situacao_nota_fiscal.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/destinatario_model.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/documento_nfce_item_model.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/documento_nfce_model.dart';
import 'package:paygo_app/infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';
import 'package:paygo_app/infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_autorizacao_dto.dart';
import 'package:paygo_app/infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_cancelamento_dto.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/destinatario_entity.dart';

import '../../../commons/components/pesquisas/pesquisa.dart';
import '../../../commons/components/pesquisas/pesquisa_produto.dart';
import '../../../commons/functions/funcoes_datetime.dart';
import '../../../commons/functions/funcoes_nuvem_fiscal.dart';
import '../../../commons/style/application_colors.dart';
import '../../../domain/models/databaase/paygo_sqlite/produto_model.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import '../../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/nfce_pedido_emissao_dto.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/documento_nfce_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/documento_nfce_item_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/produto_entity.dart';

class VendaController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoadingProdutos = false.obs;
  final _isLoadingPedidos = true.obs;
  final _campoBusca = ''.obs;
  final _incluindoItens = false.obs;
  final _vendaFinalizada = false.obs;
  final _ambiente = ''.obs;
  final _situacaoNota = '1'.obs;

  final _currentPage = 0.obs;

  final venda = DocumentoNfceModel().obs;
  final cliente = DestinatarioModel().obs;
  final pagamento = DocumentoNfcePagamentoEntity().obs;

  Rx<List<DocumentoNfceModel>> list = Rx<List<DocumentoNfceModel>>([]);
  Rx<List<DocumentoNfceItemModel>> listItens = Rx<List<DocumentoNfceItemModel>>([]);

  GlobalKey<FormState> get formKey => _formKey;

  bool get isLoadingProdutos => _isLoadingProdutos.value;
  set isLoadingProdutos(value) => _isLoadingProdutos.value = value;

  bool get isLoadingPedidos => _isLoadingPedidos.value;
  set isLoadingPedidos(value) => _isLoadingPedidos.value = value;

  String get campoBusca => _campoBusca.value;
  set campoBusca(value) => _campoBusca.value = value;

  bool get incluindoItens => _incluindoItens.value;
  set incluindoItens(value) => _incluindoItens.value = value;

  bool get vendaFinalizada => _vendaFinalizada.value;
  set vendaFinalizada(value) => _vendaFinalizada.value = value;

  int get currentPage => _currentPage.value;
  set currentPage(value) => _currentPage.value = value;

  String get ambiente => _ambiente.value;
  set ambiente(value) => _ambiente.value = value;

  String get situacaoNota => _situacaoNota.value;
  set situacaoNota(value) => _situacaoNota.value = value;

  Future<void> carregarItens() async {
    isLoadingProdutos = true;

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();

      List<DocumentoNfceItemEntity>? result = await paygoDatabaseRepository.documentoNFCeItem.listarPorIdDocumento(
        venda.value.id ?? 0,
      );

      List<DocumentoNfceItemModel> listAux = [];
      listAux.addAll(result!.map((e) => DocumentoNfceItemModel.fromJson(e.toJson())).toList());

      listItens.value.clear();
      listItens.value.addAll(listAux);
    } finally {
      isLoadingProdutos = false;
    }
  }

  Future<void> carregarLista() async {
    isLoadingPedidos = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<DocumentoNfceEntity>? result = await paygoDatabaseRepository.documentoNFCE.listar(2);

      List<DocumentoNfceModel> listAux = [];
      listAux.addAll(result!.map((e) => DocumentoNfceModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return element.cStat == 101;
          }).where((element) {
            return ((element.serie.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.nNF.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.chNFe.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.destinatarioRazaoSocial.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.destinatarioCnpjCpf.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    )));
          }),
        );
      } else {
        list.value.addAll(listAux.where((element) {
          return (((situacaoNota == '1') && (element.protocoloAutorizacao == '')) ||
              ((situacaoNota == '2') &&
                  (element.protocoloAutorizacao != '') &&
                  (element.protocoloCancelamento == '')) ||
              ((situacaoNota == '3') && (element.protocoloCancelamento != '')));
        }));
      }
    } finally {
      isLoadingPedidos = false;
    }
  }

  Future<void> salvarVenda({
    int documentoId = 0,
  }) async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();

    if (documentoId == 0) {
      await paygoDatabaseRepository.documentoNFCE.insert(
        DocumentoNfceEntity.fromMap(
          venda.value.toMap(),
        ),
      );
    } else {
      await paygoDatabaseRepository.documentoNFCE.update(
        DocumentoNfceEntity.fromMap(
          venda.value.toMap(),
        ),
      );
    }

    DocumentoNfceEntity? vendaGravada = await paygoDatabaseRepository.documentoNFCE.listarPorSerieNf(
      2,
      venda.value.serie!,
      venda.value.nNF!,
    );

    venda.update((val) {
      val!.id = vendaGravada!.id;
    });
  }

  Future<void> encerrarPagamento() async {
    PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();

    if (venda.value.situacao == 1) {
      pagamento.value = (await repository.documentoNFCePagamento.listarPorIdDocumento(
        venda.value.id ?? 0,
      ))!;
    }
    Get.back();
  }

  Future<void> iniciarVenda({
    int documentoId = 0,
  }) async {
    PaygoDatabaseRepository repository = Get.find<PaygoDatabaseRepository>();

    if (documentoId != 0) {
      DocumentoNfceEntity? result = await repository.documentoNFCE.listarPorId(
        2,
        documentoId,
      );

      venda.value = DocumentoNfceModel.fromMap(
        result!.toMap(),
      );

      try {
        if (venda.value.situacao == 1) {
          pagamento.value = (await repository.documentoNFCePagamento.listarPorIdDocumento(
            venda.value.id ?? 0,
          ))!;
        }
      } catch (e) {
        pagamento.value = DocumentoNfcePagamentoEntity();
      }

      if (venda.value.destinatarioId != null) {
        DestinatarioEntity? result = await repository.destinatario.listarPorId(
          venda.value.destinatarioId!,
        );

        cliente.value = DestinatarioModel.fromMap(
          result!.toMap(),
        );
      } else {
        cliente.value = DestinatarioModel();
      }

      await salvarVenda(documentoId: documentoId);
    } else {
      String serieNfce = await obterSerieNfce();
      int nNF = await obterProximaNumeracaoNfce();

      venda.value = DocumentoNfceModel(
        emitenteId: Get.find<ConfiguracoesSharedModel>().emitenteId,
        situacao: 0,
        serie: int.tryParse(serieNfce),
        nNF: nNF,
        dhEmi: converterDateTimeIso(DateTime.now()),
      );

      cliente.value = DestinatarioModel();

      await salvarVenda();
    }

    await carregarItens();
  }

  Future<void> identificarCliente(
    var context,
  ) async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
    List<DestinatarioEntity>? destinatario = await paygoDatabaseRepository.destinatario.listar();

    Map<String, dynamic> resultadoBusca = await showSearch(
      context: context,
      delegate: PesquisaWidget(
        destinatario!
            .map(
              (e) => {
                "display": e.nomeFantasia,
                "value": e.id,
              },
            )
            .toList(),
      ),
    );

    DestinatarioEntity? result = await paygoDatabaseRepository.destinatario.listarPorId(
      resultadoBusca['value'],
    );

    cliente.value = DestinatarioModel.fromMap(
      result!.toMap(),
    );

    venda.update(
      (campoUpdate) {
        campoUpdate!.destinatarioId = resultadoBusca['value'];
      },
    );

    salvarVenda(documentoId: venda.value.id!);
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
              DocumentoNfceEntity documentoNfceEntity = DocumentoNfceEntity.fromJson(venda.toJson());
              paygoDatabaseRepository.documentoNFCE.delete(documentoNfceEntity);
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

  Future<void> incluirProduto() async {
    PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
    List<ProdutoEntity>? produto = await paygoDatabaseRepository.produto.listar();

    List resultadoBusca = await showSearch(
      context: Get.context!,
      delegate: PesquisaProdutoWidget(
        produto!
            .map(
              (e) => {
                "id": e.id,
                "codigo": e.codigo,
                "descricao": e.descricao,
                "quantidade": 1,
                "valor": e.valor,
                "unidade": e.unidade,
                "ean": e.cean,
              },
            )
            .toList(),
      ),
    );

    for (var item in resultadoBusca) {
      ProdutoEntity? result = await paygoDatabaseRepository.produto.listarPorId(
        item['id'],
      );

      ProdutoModel produtoModel = ProdutoModel.fromMap(
        result!.toMap(),
      );

      double qtde = double.parse(item['quantidade'].toString());

      DocumentoNfceItemModel documentoNfceItemModel = DocumentoNfceItemModel(
        emitenteId: Get.find<ConfiguracoesSharedModel>().emitenteId,
        documentoId: venda.value.id!,
        produtoId: produtoModel.id!,
        cProd: int.tryParse(produtoModel.codigo!),
        produtoDescricao: produtoModel.descricao,
        uCom: produtoModel.unidade,
        qCom: qtde,
        vUnCom: produtoModel.valor,
        vProd: (produtoModel.valor! * qtde),
        vFrete: 0,
        vSeg: 0,
        vDesc: 0,
        vOutro: 0,
      );

      DocumentoNfceItemEntity documentoNfceItemEntity = DocumentoNfceItemEntity.fromJson(
        documentoNfceItemModel.toJson(),
      );

      await paygoDatabaseRepository.documentoNFCeItem.insert(
        documentoNfceItemEntity,
      );

      await totalizarVenda(venda.value.id!);

      await iniciarVenda(
        documentoId: venda.value.id!,
      );

      await carregarItens();
    }
  }

  Future<void> excluirItem(int itemId) async {
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
          'Deseja realmente excluir o item selecionado?',
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
            onPressed: () async {
              PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
              DocumentoNfceItemEntity? documentoNfceItemEntity =
                  await paygoDatabaseRepository.documentoNFCeItem.listarPorId(
                itemId,
              );

              await paygoDatabaseRepository.documentoNFCeItem.delete(
                documentoNfceItemEntity!,
              );

              await totalizarVenda(venda.value.id!);

              await iniciarVenda(
                documentoId: venda.value.id!,
              );

              await carregarItens();
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

  Future<void> emitirNFCe() async {
    var loggerNoStack = Logger(
      printer: PrettyPrinter(methodCount: 0),
    );

    NfcePedidoEmissaoDto nfce = await gerarNfce(venda.value.id!);
    loggerNoStack.i(nfce.toJson());

    DocumentosEletronicosRepository repository = Get.find<DocumentosEletronicosRepository>();
    RetornoAutorizacaoDto retorno = await repository.nfce.emitirNfce(body: nfce);

    loggerNoStack.i(retorno);

    if (retorno.autorizacao!.codigoStatus! == 100) {
      venda.update(
        (campoUpdate) {
          campoUpdate!.cStat = retorno.autorizacao!.codigoStatus!;
          campoUpdate.xMotivo = retorno.autorizacao!.motivoStatus!;
          campoUpdate.protocoloAutorizacao = retorno.autorizacao!.numeroProtocolo!;
          campoUpdate.idUnico = retorno.id!;
          campoUpdate.chNFe = retorno.autorizacao!.chaveAcesso!;
          campoUpdate.jsonAutorizacao = json.encode(retorno.toJson());
        },
      );

      salvarVenda(documentoId: venda.value.id!);
    }
  }

  Future<void> cancelarNfce() async {
    var loggerNoStack = Logger(
      printer: PrettyPrinter(methodCount: 0),
    );

    DocumentosEletronicosRepository repository = Get.find<DocumentosEletronicosRepository>();
    RetornoCancelamentoDto retorno = await repository.nfce.cancelarNfce(
      id: venda.value.idUnico!,
      justificativa: 'Cancelamento de NFC-e',
    );

    loggerNoStack.i(retorno);

    if (retorno.codigoStatus! == 135) {
      venda.update(
        (campoUpdate) {
          campoUpdate!.cStat = retorno.codigoStatus!;
          campoUpdate.xMotivo = retorno.motivoStatus!;
          campoUpdate.justificativa = 'Cancelamento de NFC-e';
          campoUpdate.protocoloCancelamento = retorno.numeroProtocolo!;
          campoUpdate.jsonCancelamento = json.encode(retorno.toJson());
        },
      );

      salvarVenda(documentoId: venda.value.id!);
    }
  }

  Future<void> finalizarVenda() async {
    if (venda.value.situacao == 0) {
      Get.toNamed(NavigationRoutes.vendasPagamento);
    } else {
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
            'Esta venda já possui pagamento, deseja autorizar o documento?',
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
              onPressed: () async {},
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
  }

  Future<void> buscarSituacao(var context) async {
    List<SituacaoNotaFiscal> listaOrigem = [
      SituacaoNotaFiscal.pendente,
      SituacaoNotaFiscal.autorizada,
      SituacaoNotaFiscal.cancelada,
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

    situacaoNota = resultadoBusca['value'].toString();
    carregarLista();
  }

  @override
  void onInit() async {
    await carregarLista();
    super.onInit();
  }
}
