import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/presentation/views/inutilizacao/inutilizacao_controller.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/style/application_colors.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';

class InutilizacaoCadastroView extends StatefulWidget {
  final String title = 'InutilizacaoCadastroView';

  const InutilizacaoCadastroView({Key? key}) : super(key: key);

  @override
  InutilizacaoCadastroViewState createState() => InutilizacaoCadastroViewState();
}

class InutilizacaoCadastroViewState extends State<InutilizacaoCadastroView> with TickerProviderStateMixin {
  bool initialAutoFocus = true;
  InutilizacaoController controller = Get.find<InutilizacaoController>();

  @override
  Widget build(BuildContext context) {
    initialAutoFocus = false;

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
              title: Text('Inutilização'),
              centerTitle: true,
            ),
            body: Form(
              key: controller.formKey,
              child: Obx(() {
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
                                  label: 'Dados da Inutilização',
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Ambiente',
                                  initialValue: Get.find<ConfiguracoesSharedModel>().ambiente,
                                  tipoCampo: TipoCampo.cep,
                                  readOnly: true,
                                  enabled: false,
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Série',
                                  initialValue: controller.serie,
                                  hintText: '0',
                                  readOnly: true,
                                  enabled: false,
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Número Inicial',
                                  initialValue: '',
                                  hintText: '0',
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.inutilizacao.value.numeroInicial = int.tryParse(value);
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Número Final',
                                  initialValue: '',
                                  hintText: '0',
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.inutilizacao.value.numeroFinal = int.tryParse(value);
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Justificativa',
                                  initialValue: controller.inutilizacaoMsg,
                                  hintText: 'Pulo de sequencia de NFC-e',
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  validator: (value) {
                                    // Justificativa deve ter pelo menos 15 caracteres
                                    if (value!.length < 15) {
                                      return 'Justificativa deve ter pelo menos 15 caracteres';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.inutilizacaoMsg = value;
                                    controller.inutilizacao.value.justificativa = controller.inutilizacaoMsg;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: controller.salvarRegistro,
                                      child: const Text(
                                        'Solicitar Inutilização',
                                        style: TextStyle(
                                          fontSize: 15,
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
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
