import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/commons/formatter/mask_formatters.dart';
import 'package:paygo_app/commons/types/ambiente.dart';
import 'package:paygo_app/domain/models/application/printer_device_model.dart';
import 'package:paygo_app/presentation/application/application_controller.dart';
import 'package:paygo_app/presentation/views/configuracoes/configuracoes_controller.dart';

import '../../../commons/components/form/form_divider_padrao.dart';
import '../../../commons/style/application_colors.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/shared_preferences/configuracoes_repository.dart';

class ConfiguracoesView extends StatefulWidget {
  final String title = 'ConfiguracoesView';

  const ConfiguracoesView({Key? key}) : super(key: key);

  @override
  ConfiguracoesViewState createState() => ConfiguracoesViewState();
}

class ConfiguracoesViewState extends State<ConfiguracoesView> with TickerProviderStateMixin {
  bool initialAutoFocus = true;
  ConfiguracoesController controller = Get.find<ConfiguracoesController>();
  ApplicationController applicationController = Get.find<ApplicationController>();

  @override
  Widget build(BuildContext context) {
    initialAutoFocus = false;

    TabController tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );

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
              title: Text('Parâmetros do Aplicativo'),
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
              bottom: TabBar(
                labelColor: ApplicationColors.paygoWhite,
                indicatorColor: ApplicationColors.paygoYellow,
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                isScrollable: false,
                onTap: (value) {},
                tabs: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'POS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'PayGO',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Dispositivos',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: Form(
              key: controller.formKey,
              child: TabBarView(
                controller: tabController,
                children: [
                  Obx(() {
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
                                      label: 'Idntificação do Emitente',
                                    ),
                                    TextFormFieldPadrao(
                                      labelText: 'Emitente',
                                      initialValue: formatarCnpjCpf(controller.emitente.value.cnpjCpf.toString()),
                                      hintText: '00.000.000/0000-00',
                                      keyboardType: TextInputType.number,
                                      readOnly: true,
                                      enabled: false,
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
                                      label: 'Parâmetros de Configuração',
                                    ),
                                    TextFormFieldPadrao(
                                      labelText: 'Ambiente',
                                      initialValue: obterAmbienteDisplay(controller.configuracao.value.ambiente!),
                                      tipoCampo: TipoCampo.cep,
                                      readOnly: true,
                                      enabled: false,
                                    ),
                                    TextFormFieldPadrao(
                                      labelText: 'Série',
                                      initialValue: controller.configuracao.value.serieNfce.toString(),
                                      //autofocus: localAutoFocus,
                                      hintText: '0',
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Campo obrigatório';
                                        }

                                        // deve ser uma serie valida para NFe
                                        if (int.parse(value) < 0 || int.parse(value) > 999) {
                                          return 'Série inválida';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        controller.configuracao.value.serieNfce = value;
                                      },
                                    ),
                                    TextFormFieldPadrao(
                                      labelText: 'última NFC-e emitida',
                                      initialValue: controller.configuracao.value.ultimaNfce.toString(),
                                      hintText: '0',
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Campo obrigatório';
                                        }

                                        // deve ser uma serie valida para NFe
                                        if (int.parse(value) < 0 || int.parse(value) > 999999999) {
                                          return 'Última NFC-e inválida';
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        controller.configuracao.value.ultimaNfce = int.parse(value);
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                                      child: Text(
                                        'Utilizar este campo para informar a última NFC-e emitida para iniciar a integração. Caso o campo esteja vazio, o sistema irá buscar a última NFC-e emitida no banco de dados.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
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
                  Padding(
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
                                    label: 'PayGO Integrado',
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.administrativoclick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Administrativo',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.instalacaoClick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Instalação',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.configuracaoClick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Configuração',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.testeComunicacaoClick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Testar Comunicação',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.versaoClick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Verificar Versão',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: applicationController.exibirPdcClick,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ApplicationColors.paygoYellow,
                                      ),
                                      child: const Text(
                                        'Exibir Código PDC',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ApplicationColors.paygoDark,
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
                  ),
                  Padding(
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
                                    label: 'Impressora',
                                  ),
                                  Obx(() {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                              value: '01',
                                              groupValue: controller.selectedPrinter,
                                              onChanged: (value) async {
                                                controller.selectedPrinter = value as String;

                                                PrinterDeviceModel printer = PrinterDeviceModel();
                                                printer.tipoImpressora = controller.selectedPrinter;
                                                printer.name = '';
                                                printer.address = '';

                                                controller.impressora = printer.name ?? '';

                                                ConfiguracoesSharedModel configuracoesModel =
                                                    Get.find<ConfiguracoesSharedModel>();

                                                configuracoesModel.impressora = printer;

                                                Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
                                                await Get.find<ConfiguracoesRepository>()
                                                    .setConfiguration(configuracoesModel);
                                              },
                                            ),
                                            Text(
                                              'Impressora Interna',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                              value: '02',
                                              groupValue: controller.selectedPrinter,
                                              onChanged: (value) {
                                                controller.selectedPrinter = value as String;
                                                controller.limparImpressora();
                                              },
                                            ),
                                            Text(
                                              'Impressora Bluetooth',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                  Obx(() {
                                    return Visibility(
                                      visible: controller.selectedPrinter == '02',
                                      child: TextFormFieldPadrao(
                                        labelText: 'Impressora',
                                        initialValue: controller.impressora,
                                        hintText: '',
                                        readOnly: true,
                                        keyboardType: TextInputType.none,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            applicationController.listarImpressoras();

                                            Get.bottomSheet(
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(20),
                                                    topRight: Radius.circular(20),
                                                  ),
                                                ),
                                                height: 250,
                                                width: 500,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Obx(
                                                        () {
                                                          return ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: applicationController.listPrinterDevice.length,
                                                            itemBuilder: (context, i) {
                                                              return InkWell(
                                                                onTap: () async {
                                                                  PrinterDeviceModel printer = PrinterDeviceModel();
                                                                  printer.tipoImpressora = controller.selectedPrinter;
                                                                  printer.name =
                                                                      applicationController.listPrinterDevice[i].name;
                                                                  printer.address = applicationController
                                                                      .listPrinterDevice[i].address;

                                                                  controller.impressora = printer.name ?? '';

                                                                  ConfiguracoesSharedModel configuracoesModel =
                                                                      Get.find<ConfiguracoesSharedModel>();

                                                                  configuracoesModel.impressora = printer;

                                                                  Get.find<ConfiguracoesSharedModel>()
                                                                      .updateData(configuracoesModel);
                                                                  await Get.find<ConfiguracoesRepository>()
                                                                      .setConfiguration(configuracoesModel);

                                                                  Get.back();
                                                                },
                                                                child: Card(
                                                                  child: ListTile(
                                                                    title: Text(applicationController
                                                                        .listPrinterDevice[i].name),
                                                                    subtitle: Text(applicationController
                                                                        .listPrinterDevice[i].address),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            FontAwesomeIcons.magnifyingGlass,
                                            color: ApplicationColors.paygoGray[500],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  Obx(() {
                                    return Visibility(
                                      visible: controller.selectedPrinter == '02',
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 45,
                                          child: ElevatedButton(
                                            onPressed: controller.limparImpressora,
                                            child: const Text(
                                              'Remover Impressora',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: ApplicationColors.paygoDark,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          applicationController.imprimirTeste();
                                        },
                                        child: const Text(
                                          'Testar Impressora',
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
