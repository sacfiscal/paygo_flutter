import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/functions/funcoes_gerais.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/components/form/form_text_form_field_padrao.dart';
import '../../../commons/formatter/mask_formatters.dart';
import '../../../commons/style/application_colors.dart';
import '../../../commons/types/indiedest.dart';

import 'cliente_controller.dart';

class ClienteCadastroView extends StatefulWidget {
  final String title = 'ClienteCadastroView';

  const ClienteCadastroView({Key? key}) : super(key: key);

  @override
  ClienteCadastroViewState createState() => ClienteCadastroViewState();
}

class ClienteCadastroViewState extends State<ClienteCadastroView> {
  bool initialAutoFocus = true;
  ClienteController controller = Get.find<ClienteController>();

  @override
  Widget build(BuildContext context) {
    bool localAutoFocus = initialAutoFocus;
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
              title: Text('Cliente'),
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
            body: Obx(
              () {
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
                                    label: 'Dados do Cliente',
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'ID',
                                    initialValue: controller.destinatario.value.id.toString(),
                                    hintText: '0',
                                    keyboardType: TextInputType.number,
                                    readOnly: true,
                                    enabled: false,
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CNPJ/CPF',
                                    initialValue: formatarCnpjCpf(controller.destinatario.value.cnpjCpf ?? ''),
                                    hintText: '00.000.000/0000-00',
                                    autofocus: localAutoFocus,
                                    tipoCampo: TipoCampo.cpfCnpj,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      var cnpjCpf = value;
                                      cnpjCpf = cnpjCpf!.replaceAll(RegExp(r'[^\d]+'), '');

                                      // O campo deve conter 11 ou 14 caracteres
                                      if (cnpjCpf.length != 11 && cnpjCpf.length != 14) {
                                        return 'O campo deve conter 11 ou 14 caracteres';
                                      }

                                      if (value == null || value.isEmpty) {
                                        return 'Informe o CNPJ/CPF';
                                      }

                                      return null;
                                    },
                                    suffixIcon: GestureDetector(
                                      onTap: controller.buscaCadastro,
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.destinatario.value.cnpjCpf = value.replaceAll(RegExp(r'[^\d]+'), '');
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Razão Social',
                                    initialValue: controller.destinatario.value.razaoSocial,
                                    maxLines: 2,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a Razão Social';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.destinatario.value.razaoSocial = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Nome Fantasia',
                                    initialValue: controller.destinatario.value.nomeFantasia,
                                    maxLines: 2,
                                    onChanged: (value) {
                                      controller.destinatario.value.nomeFantasia = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Imscrição Estadual',
                                    initialValue: controller.destinatario.value.ie,
                                    onChanged: (value) {
                                      controller.destinatario.value.ie = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'ID Estrangeiro',
                                    initialValue: controller.destinatario.value.idEstrangeiro,
                                    onChanged: (value) {
                                      controller.destinatario.value.idEstrangeiro = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                    label: 'NFC-e',
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Identificação do Destinatário',
                                    initialValue: obterIndiedestDisplay(controller.destinatario.value.indIeDest ?? ''),
                                    tipoCampo: TipoCampo.cep,
                                    readOnly: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        cancelFocus(context);
                                        controller.buscarindIeDest(context);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                  DividerPadrao(label: 'Endereço'),
                                  TextFormFieldPadrao(
                                    labelText: 'CEP',
                                    initialValue: formatarCep(controller.destinatario.value.cep ?? ''),
                                    hintText: '00000-000',
                                    tipoCampo: TipoCampo.cep,
                                    keyboardType: TextInputType.number,
                                    suffixIcon: GestureDetector(
                                      onTap: controller.buscaCep,
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.destinatario.value.cep = value.replaceAll(RegExp(r'[^\d]+'), '');
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Logradouro',
                                    initialValue: controller.destinatario.value.logradouro,
                                    maxLines: 3,
                                    onChanged: (value) {
                                      controller.destinatario.value.logradouro = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Número',
                                    initialValue: controller.destinatario.value.numero,
                                    hintText: 'S/N',
                                    onChanged: (value) {
                                      controller.destinatario.value.numero = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Complemento',
                                    initialValue: controller.destinatario.value.complemento,
                                    maxLines: 3,
                                    onChanged: (value) {
                                      controller.destinatario.value.complemento = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Bairro',
                                    initialValue: controller.destinatario.value.bairro,
                                    onChanged: (value) {
                                      controller.destinatario.value.bairro = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Código do Município',
                                    initialValue: controller.destinatario.value.codigoMunicipio,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      controller.destinatario.value.codigoMunicipio = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Município',
                                    initialValue: controller.destinatario.value.municipio,
                                    onChanged: (value) {
                                      controller.destinatario.value.municipio = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'UF',
                                    initialValue: controller.destinatario.value.uf,
                                    onChanged: (value) {
                                      controller.destinatario.value.uf = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                  DividerPadrao(label: 'Contato'),
                                  TextFormFieldPadrao(
                                    labelText: 'Telefone',
                                    initialValue: formatarTelefone(controller.destinatario.value.fone ?? ''),
                                    hintText: '(00) 00000-0000',
                                    tipoCampo: TipoCampo.telefone,
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      controller.destinatario.value.fone = value.replaceAll(RegExp(r'[^\d]+'), '');
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Email',
                                    initialValue: controller.destinatario.value.email,
                                    hintText: 'seuemail@exemplo.com.br',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o Email';
                                      }

                                      if (!GetUtils.isEmail(value)) {
                                        return 'Informe um Email válido';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.destinatario.value.email = value;
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
              },
            ),
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
