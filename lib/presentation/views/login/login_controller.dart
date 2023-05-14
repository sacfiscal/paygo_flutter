import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/usuario_entity.dart';

import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/shared_preferences/configuracoes_repository.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _login = 'admin'.obs;
  final _senha = 'admin'.obs;
  final _senhaVisivel = false.obs;
  final _lembrarLogin = false.obs;

  final _sairClicks = 0.obs;

  GlobalKey<FormState> get formKey => _formKey;

  get login => _login.value;
  set login(value) => _login.value = value;

  get senha => _senha.value;
  set senha(value) => _senha.value = value;

  get senhaVisivel => _senhaVisivel.value;
  set senhaVisivel(value) => _senhaVisivel.value = value;

  get lembrarLogin => _lembrarLogin.value;
  set lembrarLogin(value) => _lembrarLogin.value = value;

  get sairClicks => _sairClicks.value;
  set sairClicks(value) => _sairClicks.value = value;

  void setarVisibilidadeSenha() {
    senhaVisivel = !senhaVisivel;
  }

  String? loginValidator(String? value) {
    if (value!.isEmpty) {
      return 'Informe o login';
    }
    return null;
  }

  void loginChange(String? value) {
    login = value!;
  }

  String? senhaValidator(String? value) {
    if (value!.isEmpty) {
      return 'Informe a senha';
    }
    return null;
  }

  void senhaChange(String? value) {
    senha = value!;
  }

  void lembrarLoginChange(bool? value) async {
    lembrarLogin = value!;

    /* Iniciando o modelo de configurações */
    ConfiguracoesSharedModel configuracoesModel = await Get.find<ConfiguracoesRepository>().getConfiguration();

    /* Ajustando o parâmetro de manter login*/
    configuracoesModel.lembrarLogin = lembrarLogin;
    Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

    /* Atualizando o modelo de configurações */
    Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
  }

  void efetuarLogin() async {
    if (_formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      UsuarioEntity? usuarioEntity = await paygoDatabaseRepository.usuario.listarPorLogin(login);

      if (usuarioEntity != null && usuarioEntity.senha == senha) {
        if (lembrarLogin) {
          /* Iniciando o modelo de configurações */
          ConfiguracoesSharedModel configuracoesModel = await Get.find<ConfiguracoesRepository>().getConfiguration();

          /* Gravando dados de Login*/
          configuracoesModel.login = login;
          configuracoesModel.senha = senha;
          configuracoesModel.appLogado = true;

          Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

          /* Atualizando o modelo de configurações */
          Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
        } else {
          /* Iniciando o modelo de configurações */
          ConfiguracoesSharedModel configuracoesModel = await Get.find<ConfiguracoesRepository>().getConfiguration();

          /* Gravando dados de Login*/
          configuracoesModel.login = login;
          configuracoesModel.senha = senha;
          configuracoesModel.appLogado = false;

          Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

          /* Atualizando o modelo de configurações */
          Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
        }

        Get.offAllNamed(NavigationRoutes.homeV3);
      } else {
        Get.snackbar('Erro', 'Usuário ou senha inválidos');
      }
    }
  }

  void sair() async {
    sairClicks += 1;

    if (sairClicks >= 10) {
      Get.dialog(
        AlertDialog(
          title: Text(
            'Alterar empresa',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: ApplicationColors.paygoYellow,
            ),
          ),
          content: Text(
            'Deseja realmente alterar a empresa?\n\nEste procedimento irá apagar todos os dados do aplicativo e solicitar uma nova configuração.',
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
              onPressed: () {
                /* Iniciando o modelo de configurações */
                ConfiguracoesSharedModel configuracoesModel = Get.find<ConfiguracoesSharedModel>();

                /* Gravando dados de Login*/
                configuracoesModel.appLogado = false;
                configuracoesModel.empresaIdentificada = false;

                Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

                /* Atualizando o modelo de configurações */
                Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);

                Get.offAllNamed(NavigationRoutes.registro);
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
    } else {
      if (sairClicks == 9) {
        Get.snackbar(
          'Sair',
          'Clique novamente para sair',
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(20),
          backgroundColor: ApplicationColors.paygoDark,
          colorText: ApplicationColors.paygoYellow,
        );
      }
    }
  }

  @override
  void onInit() {
    lembrarLogin = Get.find<ConfiguracoesSharedModel>().lembrarLogin;

    if (lembrarLogin) {
      login = Get.find<ConfiguracoesSharedModel>().login;
      senha = Get.find<ConfiguracoesSharedModel>().senha;
    } else {
      login = '';
      senha = '';
    }

    super.onInit();
  }
}
