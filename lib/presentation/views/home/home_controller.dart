import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';

import '../../../commons/style/application_colors.dart';
import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/shared_preferences/configuracoes_repository.dart';

class HomeController extends GetxController {
  final _ambiente = ''.obs;

  String get ambiente => _ambiente.value;
  void setAmbiente(String ambiente) {
    _ambiente.value = ambiente;
  }

  void sair() async {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Sair',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        content: Text(
          'Deseja realmente sair?\n\nEste procedimento irá retornar a tela de login.',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        elevation: 2,
        actionsAlignment: MainAxisAlignment.center,
        buttonPadding: EdgeInsets.all(3),
        shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          1,
        ),
        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
        backgroundColor: ApplicationColors.paygoDark,
        titleTextStyle: TextStyle(
          color: ApplicationColors.paygoYellow,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Get.back();
            },
            child: Text(
              'Não',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ApplicationColors.paygoYellow,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              /* Iniciando o modelo de configurações */
              ConfiguracoesSharedModel configuracoesModel =
                  await Get.find<ConfiguracoesRepository>().getConfiguration();

              /* Gravando dados de Login*/

              configuracoesModel.appLogado = false;

              Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

              /* Atualizando o modelo de configurações */
              Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);

              Get.offAllNamed(NavigationRoutes.login);
            },
            child: Text(
              'Sim',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onInit() {
    setAmbiente(Get.find<ConfiguracoesSharedModel>().ambiente!);
    super.onInit();
  }
}
