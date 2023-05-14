import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/unidade_medida_model.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';
import 'package:paygo_app/presentation/views/unidade/unidade_controller.dart';

import '../../../commons/style/application_colors.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';

class UnidadeView extends StatefulWidget {
  final String title = 'UnidadeView';

  const UnidadeView({Key? key}) : super(key: key);

  @override
  UnidadeViewState createState() => UnidadeViewState();
}

class UnidadeViewState extends State<UnidadeView> with RouteAware {
  bool initialAutoFocus = true;
  UnidadeController controller = Get.find<UnidadeController>();

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

  // FormBuilder(
  //   controller: ....
  //   builder: (controller){
  //     ..
  //   }
  // )

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
              title: Text('Unidades de Medida'),
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
                                        fontSize: 13,
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
                                        return ListTile(
                                          contentPadding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                          title: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                                child: Text(
                                                  controller.list.value[index].descricao ?? '',
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Sigla da Unidade: ${controller.list.value[index].sigla ?? ''}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                  color: ApplicationColors.paygoZinc[400],
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
                                              controller.unidade.value = controller.list.value[index];
                                              Get.toNamed(NavigationRoutes.unidadesCadastro);
                                            },
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
              height: 65,
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
                  height: 55,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 6),
                    child: ElevatedButton(
                      onPressed: () async {
                        controller.unidade.value = UnidadeMedidaModel(
                          emitenteId: Get.find<ConfiguracoesSharedModel>().emitenteId,
                        );
                        Get.toNamed(NavigationRoutes.unidadesCadastro);
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
