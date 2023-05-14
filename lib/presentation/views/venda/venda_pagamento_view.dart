import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/components/form/form_text_form_field_padrao.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/presentation/application/application_controller.dart';
import 'package:paygo_app/presentation/views/venda/venda_controller.dart';

class VendasPagamentoView extends StatefulWidget {
  final String title = 'VendasPagamentoView';

  const VendasPagamentoView({Key? key}) : super(key: key);

  @override
  VendasPagamentoViewState createState() => VendasPagamentoViewState();
}

class VendasPagamentoViewState extends State<VendasPagamentoView> {
  VendaController controller = Get.find<VendaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
        centerTitle: true,
      ),
      body: Stack(
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
            body: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        return TextFormFieldPadrao(
                          labelText: 'Total',
                          initialValue: 'R\$ ${controller.venda.value.vNF?.toStringAsFixed(2)}',
                          fontSize: 40,
                          readOnly: true,
                        );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          ApplicationController applicationController = Get.find<ApplicationController>();
                          applicationController.solicitarPagamentoDinheiroClick(
                            documentoId: controller.venda.value.id ?? 0,
                            valor: controller.venda.value.vNF ?? 0,
                          );
                        },
                        child: Text('Dinheiro'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          ApplicationController applicationController = Get.find<ApplicationController>();
                          applicationController.solicitarPagamentoClick(
                            documentoId: controller.venda.value.id ?? 0,
                            valor: controller.venda.value.vNF ?? 0,
                          );
                        },
                        child: Text(
                          'TEF PayGO',
                          style: TextStyle(
                            color: ApplicationColors.paygoDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: 80,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/logo_paygo_transparente.png',
                        width: 70,
                        height: 70,
                      ),
                      Image.asset(
                        'assets/images/logo/logo_nuvem_fiscal_transparente.png',
                        width: 70,
                        height: 70,
                      ),
                    ],
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
