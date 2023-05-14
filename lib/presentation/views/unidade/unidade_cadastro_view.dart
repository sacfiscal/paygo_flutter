import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/presentation/views/unidade/unidade_controller.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/style/application_colors.dart';

class UnidadeCadastroView extends StatefulWidget {
  final String title = 'UnidadeCadastroView';

  const UnidadeCadastroView({Key? key}) : super(key: key);

  @override
  UnidadeCadastroViewState createState() => UnidadeCadastroViewState();
}

class UnidadeCadastroViewState extends State<UnidadeCadastroView> {
  bool autofocus = true;
  UnidadeController controller = Get.find<UnidadeController>();

  @override
  Widget build(BuildContext context) {
    bool localAutoFofus = autofocus;
    autofocus = false;

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
            appBar: AppBar(
              title: Text('Unidade de Medida'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.floppyDisk,
                    size: 20,
                  ),
                  onPressed: controller.salvarRegistro,
                ),
              ],
            ),
            body: Obx(() {
              if (controller.isLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90,
                        width: 90,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ApplicationColors.paygoDark,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          'Carregando...',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Card(
                          color: Colors.white.withAlpha(180),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                            child: Column(
                              children: [
                                DividerPadrao(
                                  label: 'Dados da Unidade',
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'ID',
                                  initialValue: controller.unidade.value.id.toString(),
                                  hintText: '0',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  enabled: false,
                                  onChanged: (value) {
                                    controller.unidade.value.id = int.parse(value);
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Descrição',
                                  initialValue: controller.unidade.value.descricao ?? '',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  autofocus: localAutoFofus,
                                  readOnly: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.unidade.value.descricao = value;
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Sigla',
                                  initialValue: controller.unidade.value.sigla ?? '',
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  readOnly: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.unidade.value.sigla = value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            bottomNavigationBar: Container(
              height: 65,
              color: ApplicationColors.paygoDark,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.excluirRegistro,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ApplicationColors.paygoTomato,
                    ),
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
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
