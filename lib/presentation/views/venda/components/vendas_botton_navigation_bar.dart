import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paygo_app/infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import 'package:paygo_app/presentation/application/application_controller.dart';
import 'package:paygo_app/presentation/views/venda/venda_controller.dart';

import '../../../../commons/style/application_colors.dart';

class VendasBottonNavigationBar extends StatelessWidget {
  const VendasBottonNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VendaController controller = Get.find<VendaController>();

    return Obx(
      () {
        return ((controller.venda.value.protocoloAutorizacao.toString().trim() != 'null') &&
                (controller.venda.value.protocoloAutorizacao.toString().trim() != ''))
            ? BottomAppBar(
                height: 65,
                color: ApplicationColors.paygoDark,
                shape: CircularNotchedRectangle(),
                notchMargin: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: !(controller.venda.value.protocoloCancelamento.toString().trim() != 'null' &&
                            controller.venda.value.protocoloCancelamento.toString().trim() != ''),
                        child: _buildIconButton(
                          icon: FontAwesomeIcons.ban,
                          text: 'Cancelar',
                          isSelected: true,
                          selectedColor: ApplicationColors.paygoAmber[900],
                          color: ApplicationColors.paygoWhite,
                          iconSize: 25,
                          onTap: controller.cancelarNfce,
                        ),
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.print,
                        text: 'Imprimir',
                        onTap: () async {
                          if (controller.venda.value.escpos.toString().trim() == 'null' ||
                              controller.venda.value.escpos.toString().trim() == '') {
                            DocumentosEletronicosRepository repository = Get.find<DocumentosEletronicosRepository>();

                            String xml = await repository.nfce.baixarEscpos(
                              id: controller.venda.value.idUnico!,
                              modelo: 0,
                            );

                            var loggerNoStack = Logger(
                              printer: PrettyPrinter(methodCount: 0),
                            );

                            loggerNoStack.i(xml);

                            controller.venda.update(
                              (val) {
                                val!.escpos = xml;
                              },
                            );

                            controller.salvarVenda(
                              documentoId: controller.venda.value.id!,
                            );
                          }

                          ApplicationController applicationController = Get.find<ApplicationController>();
                          applicationController.imprimir(controller.venda.value.escpos!);
                        },
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.arrowUpRightFromSquare,
                        text: 'Compartilhar',
                        onTap: () {},
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.doorOpen,
                        text: 'Sair',
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              )
            : BottomAppBar(
                height: 65,
                color: ApplicationColors.paygoDark,
                shape: CircularNotchedRectangle(),
                notchMargin: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: (controller.venda.value.situacao == 0),
                        child: _buildIconButton(
                          icon: FontAwesomeIcons.thumbsUp,
                          text: 'Finalizar',
                          isSelected: true,
                          onTap: controller.finalizarVenda,
                          color: ApplicationColors.paygoDark,
                        ),
                      ),
                      Visibility(
                        visible: (controller.venda.value.situacao != 0),
                        child: _buildIconButton(
                          icon: FontAwesomeIcons.shareFromSquare,
                          text: 'Transmitir',
                          iconSize: 25,
                          isSelected: true,
                          onTap: controller.emitirNFCe,
                          selectedColor: Color.fromARGB(255, 78, 81, 204),
                          color: ApplicationColors.paygoWhite,
                        ),
                      ),
                      Visibility(
                        visible: (controller.venda.value.situacao == 0),
                        child: _buildIconButton(
                          icon: FontAwesomeIcons.trash,
                          text: 'Excluir',
                          onTap: controller.excluirRegistro,
                        ),
                      ),
                      Visibility(
                        visible: (controller.venda.value.situacao == 0),
                        child: _buildIconButton(
                          icon: FontAwesomeIcons.circlePlus,
                          text: '',
                          iconSize: 55,
                          onTap: controller.incluirProduto,
                        ),
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.userLarge,
                        text: 'Identificar',
                        onTap: () {
                          controller.identificarCliente(context);
                        },
                      ),
                      _buildIconButton(
                        icon: FontAwesomeIcons.doorOpen,
                        text: 'Sair',
                        onTap: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

Widget _buildIconButton({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  bool isSelected = false,
  double iconSize = 25.0,
  Color? color,
  Color? selectedColor = ApplicationColors.paygoYellow,
}) {
  final iconColor = isSelected ? color : Colors.white;
  final textColor = isSelected ? color : Colors.grey[500];

  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: (isSelected) ? selectedColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 56.0,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            (text.trim() != '')
                ? Column(
                    children: [
                      SizedBox(height: 4.0),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    ),
  );
}
