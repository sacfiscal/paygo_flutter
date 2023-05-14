import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/commons/functions/funcoes_datetime.dart';
import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';
import 'package:paygo_app/presentation/views/inutilizacao/inutilizacao_controller.dart';

import '../../../commons/style/application_colors.dart';
import '../../../commons/types/ambiente.dart';
import '../../../domain/models/databaase/paygo_sqlite/inutilizacao_model.dart';

class InutilizacaoView extends StatefulWidget {
  final String title = 'InutilizacaoView';

  const InutilizacaoView({Key? key}) : super(key: key);

  @override
  InutilizacaoViewState createState() => InutilizacaoViewState();
}

class InutilizacaoViewState extends State<InutilizacaoView> with RouteAware {
  bool initialAutoFocus = true;
  InutilizacaoController controller = Get.find<InutilizacaoController>();

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
              title: Text('Inutilização'),
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
                    child: TextFormFieldPadrao(
                      labelText: 'Pesquisar',
                      initialValue: controller.campoBusca,
                      hintText: 'Pesquisar',
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
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      return controller.isLoadList
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
                                          height: 6,
                                          color: ApplicationColors.paygoDark,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: ListTile(
                                            contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                                            title: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Text(
                                                    'Sequencia Inutilizada: ${controller.list.value[index].numeroInicial.toString()}-${controller.list.value[index].numeroFinal.toString()}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                                                  child: Text(
                                                    'Data: ${isoToBrDateTimeString(controller.list.value[index].dhInutilizacao.toString())}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  'Protocolo de Inutilização: ${controller.list.value[index].protocoloInutilizacao.toString()}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: ApplicationColors.paygoZinc[800],
                                                  ),
                                                ),
                                              ],
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
              height: 60,
              decoration: BoxDecoration(
                color: ApplicationColors.paygoDark,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 6),
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.inutilizacao.value = InutilizacaoModel(
                          tpAmb: obterAmbienteFromDisplay(Get.find<ConfiguracoesSharedModel>().ambiente!).value,
                          serie: int.tryParse(controller.serie),
                          emitenteId: Get.find<ConfiguracoesSharedModel>().emitenteId,
                          justificativa: 'Pulo de sequencia de NFCe',
                        );
                        Get.toNamed(NavigationRoutes.inutilizacaoCadastro);
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
