import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../commons/formatter/mask_formatters.dart';
import '../../../commons/style/application_colors.dart';
import './registro_controller.dart';

class RegistroView extends StatefulWidget {
  final String title = 'RegistroView';

  const RegistroView({Key? key}) : super(key: key);

  @override
  RegistroViewState createState() => RegistroViewState();
}

class RegistroViewState extends State<RegistroView> {
  RegistroController controller = RegistroController();

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
                          padding: const EdgeInsets.fromLTRB(45, 45, 45, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Olá,',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 25, 0, 40),
                                child: Text(
                                  'Para iniciar o uso do aplicativo é necessário informar o CNPJ da empresa cadastrada na API da Nuvem Fiscal.,',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Obx(
                                () {
                                  return TextFormField(
                                    initialValue: TextEditingController(
                                      text: formatarCnpjCpf(controller.cnpjEmpresa),
                                    ).text,
                                    validator: controller.cnpjEmpresaValidator,
                                    style: TextStyle(
                                      color: ApplicationColors.paygoDark,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(18),
                                      FilteringTextInputFormatter.digitsOnly,
                                      CnpjCpfFormatter(),
                                    ],
                                    decoration: InputDecoration(
                                      labelText: 'CNPJ',
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
                                      hintText: '00.000.000/0000-00',
                                    ),
                                    onChanged: controller.cnpjEmpresaChange,
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 36, 0, 36),
                                child: SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: controller.efetuarLogin,
                                    child: const Text(
                                      'Iniciar',
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
                                  const Text(
                                    'Ainda não possui o cadastro?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ApplicationColors.paygoDark,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Text(
                                    'Entre em contato no link abaixo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ApplicationColors.paygoDark,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: controller.abrirUrl,
                                      child: const Text(
                                        'httt://www.nuvemfiscal.com.br',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                      Image.asset(
                        'assets/images/logo/logo_paygo_transparente.png',
                        width: 100,
                        height: 100,
                      ),
                      Image.asset(
                        'assets/images/logo/logo_nuvem_fiscal_transparente.png',
                        width: 100,
                        height: 100,
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
