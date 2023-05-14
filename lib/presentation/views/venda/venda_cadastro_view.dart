import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/presentation/views/venda/venda_controller.dart';
import '../../../../presentation/views/venda/components/vendas_total_v1.dart';
import '../../../commons/functions/funcoes_datetime.dart';
import '../../../commons/style/application_colors.dart';
import 'components/vendas_botton_navigation_bar.dart';

class VendaCadastroView extends StatefulWidget {
  final String title = 'VendaCadastroView';

  const VendaCadastroView({Key? key}) : super(key: key);

  @override
  VendaCadastroViewState createState() => VendaCadastroViewState();
}

class VendaCadastroViewState extends State<VendaCadastroView> with TickerProviderStateMixin, RouteAware {
  VendaController controller = Get.find<VendaController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Get.find<RouteObserver>().subscribe(
      this,
      ModalRoute.of(context) as PageRoute,
    );
  }

  @override
  void didPopNext() {
    controller.carregarItens();
  }

  @override
  void dispose() {
    Get.find<RouteObserver>().unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.carregarItens();
  }

  @override
  Widget build(BuildContext context) {
    controller.incluindoItens = false;

    return KeyboardDismisser(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBody: false,
              extendBodyBehindAppBar: false,
              appBar: (1 == 1)
                  ? null
                  : AppBar(
                      title: Column(
                        children: [
                          Text(
                            'Inclusão de venda',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      actions: [],
                      centerTitle: true,
                      elevation: 0,
                    ),
              body: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 2),
                    decoration: BoxDecoration(
                      color: ApplicationColors.paygoDark,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Obx(() {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: TextFormFieldPadrao(
                                    labelText: 'Série',
                                    initialValue: controller.venda.value.serie?.toString(),
                                    contentPadding: EdgeInsets.all(0),
                                    readOnly: true,
                                    enabled: false,
                                    isDense: true,
                                    disableColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: TextFormFieldPadrao(
                                    labelText: 'Número',
                                    initialValue: controller.venda.value.nNF?.toString(),
                                    contentPadding: EdgeInsets.all(0),
                                    readOnly: true,
                                    enabled: false,
                                    isDense: true,
                                    disableColor: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextFormFieldPadrao(
                                    labelText: 'Emissão',
                                    initialValue: isoToBrDateTimeString(controller.venda.value.dhEmi),
                                    contentPadding: EdgeInsets.all(0),
                                    readOnly: true,
                                    enabled: false,
                                    isDense: true,
                                    disableColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormFieldPadrao(
                            labelText: 'Cliente',
                            initialValue: controller.cliente.value.obterIdentificacao(
                              incluirCnpjCpf: true,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 5),
                            readOnly: true,
                            enabled: false,
                            isDense: true,
                            disableColor: Colors.white,
                            maxLines: 2,
                            fontSize: 10,
                          ),
                          (controller.venda.value.situacao == 0)
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'PAGAMENTO REALIZADO',
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          (controller.pagamento.value.transactionResult.toString() != '0')
                                              ? Text(
                                                  'Código de Retorno: ${controller.pagamento.value.transactionResult}',
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 12,
                                                  ),
                                                )
                                              : Text(
                                                  (controller.venda.value.situacao == 1)
                                                      ? 'Código da Autorização: ${controller.pagamento.value.authorizationCode}'
                                                      : 'Pago em Dinheiro',
                                                  style: TextStyle(
                                                    color: Colors.greenAccent,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                          Visibility(
                                            visible: (controller.venda.value.situacao == 1),
                                            child: Text(
                                              'ID: ${controller.pagamento.value.confirmationTransactionId}',
                                              style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: (controller.venda.value.situacao == 1),
                                            child: Text(
                                              'Message: ${controller.pagamento.value.resultMessage}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.greenAccent,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      );
                    }),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Obx(
                        () {
                          return controller.isLoadingProdutos
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: LoadingAnimationWidget.hexagonDots(
                                          color: ApplicationColors.paygoDark[500]!,
                                          size: 100,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          'Carregando...',
                                          style: TextStyle(
                                            color: ApplicationColors.paygoDark[500],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: controller.listItens.value.length,
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  itemBuilder: (context, indice) {
                                    return Card(
                                      color: Colors.white.withAlpha(180),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.listItens.value[indice].produtoDescricao ?? '',
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Qtde: ${controller.listItens.value[indice].qCom?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                  Text(
                                                    'Valor unitário: ${controller.listItens.value[indice].vUnCom?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[700],
                                                    ),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Unidade: ${controller.listItens.value[indice].uCom}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Valor: R\$ ${controller.listItens.value[indice].vProd?.toStringAsFixed(2)}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: (controller.venda.value.situacao == 0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                                onPressed: () async {
                                                  await controller.excluirItem(controller.listItens.value[indice].id!);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () {
                      return Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: ApplicationColors.paygoDark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          children: [
                            VendasTotal(
                              label: 'Valor dos Produtos',
                              valorTotal: controller.venda.value.vProd!,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            VendasTotal(
                              label: 'Valor do Desconto',
                              valorTotal: controller.venda.value.vDesc!,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                              child: Divider(
                                color: Colors.white,
                                height: 2,
                              ),
                            ),
                            VendasTotal(
                              label: 'Valor Total',
                              valorTotal: controller.venda.value.vNF!,
                            ),
                            (controller.venda.value.cStat == 0)
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          (controller.venda.value.cStat == 100)
                                              ? 'NFC-e Autorizada'
                                              : 'NFC-e Cancelada',
                                          style: TextStyle(
                                            color: (controller.venda.value.cStat == 100)
                                                ? ApplicationColors.paygoYellow
                                                : ApplicationColors.paygoAmber[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          controller.venda.value.chNFe ?? '',
                                          style: TextStyle(
                                            color: (controller.venda.value.cStat == 100)
                                                ? ApplicationColors.paygoYellow
                                                : ApplicationColors.paygoAmber[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          'Protocolo: ${(controller.venda.value.cStat == 100) ? controller.venda.value.protocoloAutorizacao ?? '' : controller.venda.value.protocoloCancelamento ?? ''}',
                                          style: TextStyle(
                                            color: (controller.venda.value.cStat == 100)
                                                ? ApplicationColors.paygoYellow
                                                : ApplicationColors.paygoAmber[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
              bottomNavigationBar: VendasBottonNavigationBar(),
            ),
          ),
        ],
      ),
    );
  }
}
