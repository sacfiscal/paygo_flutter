import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/presentation/views/usuario/usuario_controller.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/style/application_colors.dart';

class UsuarioCadastroView extends StatefulWidget {
  final String title = 'UsuarioCadastroView';

  const UsuarioCadastroView({Key? key}) : super(key: key);

  @override
  UsuarioCadastroViewState createState() => UsuarioCadastroViewState();
}

class UsuarioCadastroViewState extends State<UsuarioCadastroView> {
  bool autofocus = true;
  UsuarioController controller = Get.find<UsuarioController>();

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
              title: Text('Usuário'),
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
                                  label: 'Dados do Usuário',
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'ID',
                                  initialValue: controller.usuario.value.id.toString(),
                                  hintText: '0',
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  readOnly: true,
                                  enabled: false,
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Nome',
                                  initialValue: controller.usuario.value.nome,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  autofocus: localAutoFofus,
                                  readOnly: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Informe o nome';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.usuario.value.nome = value;
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'Login',
                                  initialValue: controller.usuario.value.login,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  readOnly: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Informe o login';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.usuario.value.login = value;
                                  },
                                ),
                                TextFormFieldPadrao(
                                  labelText: 'senha',
                                  initialValue: controller.usuario.value.senha,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  readOnly: false,
                                  obscureText: !controller.senhaVisivel,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.senhaVisivel ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                      color: ApplicationColors.paygoDark[500],
                                    ),
                                    onPressed: controller.setarVisibilidadeSenha,
                                  ),
                                  validator: (value) {
                                    // Senha deve ter no mínimo 6 caracteres
                                    if (value.toString().length < 6) {
                                      return 'A senha deve ter no mínimo 6 caracteres';
                                    }

                                    // Senha deve ter caracteres alfanuméricos de a-z e 0-9 combinados
                                    if (!RegExp(r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{6,}$').hasMatch(value.toString())) {
                                      return 'A senha deve conter letras e números';
                                    }

                                    if (value == null || value.isEmpty) {
                                      return 'Informe a senha';
                                    }

                                    return null;
                                  },
                                  onChanged: (value) {
                                    controller.usuario.value.senha = value;
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
