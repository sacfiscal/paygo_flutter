import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/presentation/views/login/login_controller.dart';

class LoginView extends StatefulWidget {
  final String title = 'LoginView';

  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isVisible) {
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
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: controller.formKey,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(45, 0, 45, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 52, 0, 52),
                                child: Text(
                                  'Acessar Conta',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: TextFormField(
                                  initialValue: TextEditingController(
                                    text: controller.login,
                                  ).text,
                                  validator: controller.loginValidator,
                                  style: TextStyle(
                                    color: ApplicationColors.paygoDark,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [],
                                  decoration: InputDecoration(
                                    labelText: 'Login',
                                    labelStyle: TextStyle(
                                      color: ApplicationColors.paygoDark,
                                    ),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ApplicationColors.paygoDark[300]!,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ApplicationColors.paygoDark[200]!,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: ApplicationColors.paygoYellow[900]!,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  onChanged: controller.loginChange,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Obx(
                                  () {
                                    return TextFormField(
                                      initialValue: TextEditingController(
                                        text: controller.senha,
                                      ).text,
                                      validator: controller.senhaValidator,
                                      style: TextStyle(
                                        color: ApplicationColors.paygoDark,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      onEditingComplete: controller.efetuarLogin,
                                      inputFormatters: [],
                                      obscureText: !controller.senhaVisivel,
                                      decoration: InputDecoration(
                                        labelText: 'Senha',
                                        labelStyle: TextStyle(
                                          color: ApplicationColors.paygoDark,
                                        ),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        suffixIcon: GestureDetector(
                                          onTap: controller.setarVisibilidadeSenha,
                                          child: Icon(
                                            controller.senhaVisivel ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                                            color: ApplicationColors.paygoDark[500],
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ApplicationColors.paygoDark[300]!,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ApplicationColors.paygoDark[200]!,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ApplicationColors.paygoYellow[900]!,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      onChanged: controller.senhaChange,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                                child: SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: controller.efetuarLogin,
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ApplicationColors.paygoDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Obx(
                                          () => Switch(
                                            value: controller.lembrarLogin,
                                            onChanged: controller.lembrarLoginChange,
                                          ),
                                        ),
                                        Text('Lembrar de mim'),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Ainda não possui usuário?',
                                    style: TextStyle(
                                      color: ApplicationColors.paygoDark,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Criar usuário',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: SizedBox(
                  height: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/Logo_SACFiscal_vazada1.png',
                        width: 100,
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: controller.sair,
                        child: Image.asset(
                          'assets/images/logo/logo_paygo_transparente.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.sair,
                        child: Image.asset(
                          'assets/images/logo/logo_nuvem_fiscal_transparente.png',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
