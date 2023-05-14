import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:paygo_app/commons/functions/funcoes_database.dart';
import 'package:paygo_app/commons/types/situacao_nota_fiscal.dart';
import 'package:paygo_app/presentation/views/venda/venda_controller.dart';

import '../../../commons/components/form/form_text_form_field_padrao.dart';
import '../../../commons/formatter/mask_formatters.dart';
import '../../../commons/functions/funcoes_datetime.dart';
import '../../../commons/style/application_colors.dart';
import '../../../infrastructure/routes/navigation_pages.dart';

class VendaView extends StatefulWidget {
  final String title = 'VendaView';

  const VendaView({Key? key}) : super(key: key);

  @override
  VendaViewState createState() => VendaViewState();
}

class VendaViewState extends State<VendaView> with RouteAware {
  VendaController controller = Get.put(VendaController());

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: 'R\$',
  );

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
    controller.carregarLista();
  }

  @override
  void dispose() {
    Get.find<RouteObserver>().unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text('Cupons Emitidos'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowsRotate,
                    size: 20,
                  ),
                  onPressed: () async {
                    await controller.carregarLista();
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                Form(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
                    child: Column(
                      children: [
                        TextFormFieldPadrao(
                          labelText: 'Pesquisar',
                          initialValue: controller.campoBusca,
                          hintText: 'Pesquisar',
                          isDense: true,
                          suffixIcon: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: ApplicationColors.paygoGray[500],
                            ),
                          ),
                          onChanged: (value) async {
                            controller.campoBusca = value.toString();
                            await controller.carregarLista();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      return controller.isLoadingPedidos
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
                          : Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: controller.list.value.length,
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          height: 1,
                                          color: ApplicationColors.paygoGray[500],
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          child: ListTile(
                                            contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                            title: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          'Nota Fiscal: ${controller.list.value[index].nNF.toString()}',
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            overflow: TextOverflow.ellipsis,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                      ),
                                                      (controller.list.value[index].protocoloCancelamento
                                                                      .toString()
                                                                      .trim() !=
                                                                  'null' &&
                                                              controller.list.value[index].protocoloCancelamento
                                                                      .toString()
                                                                      .trim() !=
                                                                  '')
                                                          ? Container(
                                                              width: 65,
                                                              padding: EdgeInsets.all(1),
                                                              decoration: BoxDecoration(
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  ' Cancelada ',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 8,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Row(
                                                              children: [
                                                                Visibility(
                                                                  visible: controller.list.value[index].situacao == 0,
                                                                  child: Container(
                                                                    width: 65,
                                                                    padding: EdgeInsets.all(1),
                                                                    decoration: BoxDecoration(
                                                                      color: ApplicationColors.paygoYellow,
                                                                      borderRadius: BorderRadius.circular(5),
                                                                      border: Border.all(
                                                                        color: ApplicationColors.paygoDark,
                                                                        width: 1,
                                                                      ),
                                                                    ),
                                                                    child: Center(
                                                                      child: Text(
                                                                        ' Em edição ',
                                                                        style: TextStyle(
                                                                          color: ApplicationColors.paygoDark,
                                                                          fontSize: 8,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: controller.list.value[index].situacao != 0,
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 3,
                                                                      ),
                                                                      Container(
                                                                        width: 65,
                                                                        padding: EdgeInsets.all(1),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors.green[800],
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                            ' Recebido ',
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 8,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: controller.list.value[index].chNFe != '',
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width: 3,
                                                                      ),
                                                                      Container(
                                                                        width: 65,
                                                                        padding: EdgeInsets.all(1),
                                                                        decoration: BoxDecoration(
                                                                          color: Color.fromARGB(155, 78, 81, 204),
                                                                          borderRadius: BorderRadius.circular(5),
                                                                        ),
                                                                        child: Center(
                                                                          child: Text(
                                                                            ' Autorizado ',
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 8,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                                                  child: Text(
                                                    () {
                                                      var razaoSocial =
                                                          controller.list.value[index].destinatarioRazaoSocial;
                                                      var cnpjCpf = controller.list.value[index].destinatarioCnpjCpf;

                                                      if (razaoSocial?.trim() != '' && razaoSocial?.trim() != null) {
                                                        return '$razaoSocial (${formatarCnpjCpf(cnpjCpf ?? '')})';
                                                      } else {
                                                        return 'CLIENTE NÃO IDENTIFICADO';
                                                      }
                                                    }(),
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      color: ApplicationColors.paygoZinc[800],
                                                    ),
                                                  ),
                                                ),
                                                FutureBuilder(
                                                    future: obterStatusPagamento(controller.list.value[index].id!),
                                                    builder: (context, snapshot) {
                                                      return Padding(
                                                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 1),
                                                        child: Visibility(
                                                          visible: snapshot.data != null,
                                                          child: Text(
                                                            (snapshot.data != null) ? snapshot.data!['retorno'] : '',
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                              overflow: TextOverflow.ellipsis,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12,
                                                              color: (snapshot.data == null)
                                                                  ? ApplicationColors.paygoZinc[800]
                                                                  : (snapshot.data!['transactionResult'] != '0')
                                                                      ? ApplicationColors.paygoTomato
                                                                      : Colors.green[900],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Text(
                                                    'Série: ${controller.list.value[index].serie ?? ''}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Text(
                                                    'Emissão: ${isoToBrDateTimeString(
                                                      controller.list.value[index].dhEmi ?? ' ',
                                                    )}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Text(
                                                    'Valor: ${_formatter.format(controller.list.value[index].vNF!.toStringAsFixed(2))}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                              icon: const FaIcon(
                                                FontAwesomeIcons.penToSquare,
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                controller.iniciarVenda(
                                                  documentoId: controller.list.value[index].id!,
                                                );
                                                Get.toNamed(NavigationRoutes.vendasCadastro);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 112,
              padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
              decoration: BoxDecoration(
                color: ApplicationColors.paygoDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Column(
                children: [
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 6),
                      child: TextFormFieldPadrao(
                        labelText: 'Status da venda',
                        initialValue: obterSituacaoNotaFiscal(controller.situacaoNota).display,
                        hintText: 'Pesquisar',
                        alternativeColor: Colors.white,
                        isDense: true,
                        readOnly: true,
                        contentPadding: EdgeInsets.all(0),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.buscarSituacao(context);
                          },
                          child: Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: ApplicationColors.paygoGray[500],
                          ),
                        ),
                        onChanged: (value) async {
                          controller.campoBusca = value.toString();
                          await controller.carregarLista();
                        },
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          controller.iniciarVenda();
                          Get.toNamed(NavigationRoutes.vendasCadastro);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ApplicationColors.paygoYellow,
                        ),
                        child: const Text(
                          'Incluir',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: ApplicationColors.paygoDark,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
