import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/commons/functions/funcoes_gerais.dart';
import 'package:paygo_app/commons/types/origem.dart';
import 'package:paygo_app/commons/types/status.dart';
import 'package:paygo_app/presentation/views/produto/produto_controller.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/functions/funcoes_ean.dart';
import '../../../commons/style/application_colors.dart';

class ProdutoCadastroView extends StatefulWidget {
  final String title = 'ProdutoCadastroView';

  const ProdutoCadastroView({Key? key}) : super(key: key);

  @override
  ProdutoCadastroViewState createState() => ProdutoCadastroViewState();
}

class ProdutoCadastroViewState extends State<ProdutoCadastroView> {
  bool initialAutoFocus = true;
  ProdutoController controller = Get.put(ProdutoController());

  @override
  void initState() {
    super.initState();
  }

  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    locale: 'pt_BR',
    decimalDigits: 2,
    symbol: '',
  );

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
              title: Text('Produto'),
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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                                    label: 'Dados do Produto',
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'ID',
                                    initialValue: controller.produto.value.id.toString(),
                                    tipoCampo: TipoCampo.id,
                                    hintText: '0',
                                    readOnly: true,
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Status',
                                    initialValue:
                                        obterStatusDisplay((controller.produto.value.ativo ?? false) ? '1' : '0'),
                                    tipoCampo: TipoCampo.cep,
                                    readOnly: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        cancelFocus(context);
                                        controller.buscarStatus(context);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Código',
                                    initialValue: controller.produto.value.codigo,
                                    tipoCampo: TipoCampo.codigo,
                                    keyboardType: TextInputType.number,
                                    autofocus: localAutoFocus,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe o código do produto';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.codigo = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Descrição',
                                    initialValue: controller.produto.value.descricao,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a descrição do produto';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.descricao = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Unidade',
                                    initialValue: controller.produto.value.unidade,
                                    readOnly: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        cancelFocus(context);
                                        await controller.buscarUnidade(context);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a unidade do produto';
                                      }

                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.unidade = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Valor',
                                    initialValue: _formatter.format(controller.produto.value.valor!.toStringAsFixed(2)),
                                    hintText: '0,00',
                                    tipoCampo: TipoCampo.valor,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      controller.produto.value.valor =
                                          double.parse(value.replaceAll('.', '').replaceAll(',', '.'));
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CEAN',
                                    initialValue: controller.produto.value.cean,
                                    hintText: 'SEM GTIN',
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      controller.produto.value.cean = value;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }

                                      if (!isValidEan(value)) {
                                        return 'CEAN inválido';
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Código de barras',
                                    initialValue: controller.produto.value.cbarra,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    onChanged: (value) {
                                      controller.produto.value.cbarra = value;
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
                                    label: 'Tributação',
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'NCM',
                                    initialValue: controller.produto.value.ncm,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.ncm = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CEST',
                                    initialValue: controller.produto.value.cest,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.cest = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CFOP',
                                    initialValue: controller.produto.value.cfop != null
                                        ? controller.produto.value.cfop.toString()
                                        : '',
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.cfop = int.tryParse(value);
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Código ANP',
                                    initialValue: controller.produto.value.codigoAnp,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    onChanged: (value) {
                                      controller.produto.value.codigoAnp = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'Origem',
                                    maxLines: 3,
                                    initialValue: obterOrigemDisplay(controller.produto.value.origem ?? '0'),
                                    readOnly: true,
                                    suffixIcon: GestureDetector(
                                      onTap: () async {
                                        cancelFocus(context);
                                        await controller.buscarOrigem(context);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.magnifyingGlass,
                                        color: ApplicationColors.paygoGray[500],
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Informe a origem do produto';
                                      }

                                      return null;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CST ICMS',
                                    initialValue: controller.produto.value.cstIcms,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.cstIcms = value;
                                    },
                                  ),
                                  TextFormFieldPadrao(
                                    labelText: 'CST PIS/COFINS',
                                    initialValue: controller.produto.value.cstpiscofins,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    readOnly: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      controller.produto.value.cstpiscofins = value;
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
