import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/formatter/mask_formatters.dart';
import 'package:paygo_app/commons/functions/funcoes_gerais.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/commons/components/form/form_divider_padrao.dart';
import 'package:paygo_app/commons/types/crt.dart';
import 'package:paygo_app/presentation/views/empresa/empresa_controller.dart';

import '../../../commons/components/form/form_text_form_field_padrao.dart';

class EmpresaView extends StatefulWidget {
  final String title = 'EmpresaView';

  const EmpresaView({Key? key}) : super(key: key);

  @override
  EmpresaViewState createState() => EmpresaViewState();
}

class EmpresaViewState extends State<EmpresaView> {
  bool initialAutoFocus = true;
  EmpresaController controller = Get.find<EmpresaController>();

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
              title: Text('Configurações da Empresa'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.floppyDisk,
                    size: 20,
                  ),
                  onPressed: controller.salvar,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  DividerPadrao(label: 'Dados da Empresa'),
                                  TextFormFieldPadrao(
                                    labelText: 'CNPJ/CPF',
                                    initialValue: formatarCnpjCpf(controller.emitente.value.cnpjCpf ?? ''),
                                    hintText: '00.000.000/0000-00',
                                    tipoCampo: TipoCampo.cpfCnpj,
                                    autofocus: localAutoFocus,
                                    validator: (value) {
                                      // Campo deve ter 11 ou 14 caracteres
                                      if (value == null || value.isEmpty || value.length != 14 && value.length != 18) {
                                        return 'Campo obrigatório';
                                      }

                                      if (value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }

                                      return null;
                                    },
                                    readOnly: true,
                                    enabled: false,
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Razao Social',
                                    initialValue: controller.emitente.value.razaoSocial,
                                    autofocus: localAutoFocus,
                                    maxLines: 2,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.razaoSocial = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Nome Fantasia',
                                    initialValue: controller.emitente.value.nomeFantasia,
                                    maxLines: 2,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.nomeFantasia = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Inscrição Estadual',
                                    initialValue: controller.emitente.value.ie,
                                    onChanged: (value) {
                                      controller.emitente.value.ie = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CRT',
                                    initialValue: obterCrtDisplay(controller.emitente.value.crt ?? ''),
                                    tipoCampo: TipoCampo.cep,
                                    readOnly: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        cancelFocus(context);
                                        controller.buscarCrt(context);
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
                                  DividerPadrao(label: 'NFC-e'),
                                  TextFormFieldPadrao(
                                    labelText: 'ID CSC',
                                    initialValue: controller.emitente.value.idCsc,
                                    readOnly: true,
                                    enabled: false,
                                    onChanged: (value) {
                                      controller.emitente.value.idCsc = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CSC',
                                    initialValue: controller.emitente.value.csc,
                                    readOnly: true,
                                    enabled: false,
                                    maxLines: 2,
                                    onChanged: (value) {
                                      controller.emitente.value.csc = value;
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
                                  DividerPadrao(label: 'Endereço'),
                                  TextFormFieldPadrao(
                                    labelText: 'CEP',
                                    initialValue: formatarCep(controller.emitente.value.cep ?? ''),
                                    hintText: '00000-000',
                                    tipoCampo: TipoCampo.cep,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty || value.length != 9) {
                                        return 'Campo obrigatório';
                                      }

                                      return null;
                                    },
                                    suffixIcon: GestureDetector(
                                      onTap: controller.buscaCep,
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                    onChanged: (value) {
                                      controller.emitente.value.cep = value.replaceAll(RegExp(r'[^\d]+'), '');
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Logradouro',
                                    initialValue: controller.emitente.value.logradouro,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    maxLines: 3,
                                    onChanged: (value) {
                                      controller.emitente.value.logradouro = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Número',
                                    initialValue: controller.emitente.value.numero,
                                    hintText: 'S/N',
                                    onChanged: (value) {
                                      controller.emitente.value.numero = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Complemento',
                                    initialValue: controller.emitente.value.complemento,
                                    maxLines: 3,
                                    onChanged: (value) {
                                      controller.emitente.value.complemento = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Bairro',
                                    initialValue: controller.emitente.value.bairro,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.bairro = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Código Municipio',
                                    initialValue: controller.emitente.value.codigoMunicipio,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }

                                      //Deve ser um código IBGE válido conforme a tabela do IBGE
                                      if (value.toString().length != 7) {
                                        return 'Código IBGE inválido';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.codigoMunicipio = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Município',
                                    initialValue: controller.emitente.value.municipio,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.municipio = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'UF',
                                    initialValue: controller.emitente.value.uf,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.emitente.value.uf = value;
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
                                    labelText: 'Fone',
                                    initialValue: formatarTelefone(controller.emitente.value.fone ?? ''),
                                    hintText: '(00) 00000-0000',
                                    tipoCampo: TipoCampo.telefone,
                                    keyboardType: TextInputType.phone,
                                    onChanged: (value) {
                                      controller.emitente.value.fone = value.replaceAll(RegExp(r'[^\d]+'), '');
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
          ),
        ],
      ),
    );
  }
}
