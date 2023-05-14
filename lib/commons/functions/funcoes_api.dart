import 'package:get/get.dart';
import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/repositories/api/nuvem_fiscal/autenticacao/access_token_repository.dart';
import 'package:paygo_app/infrastructure/repositories/shared_preferences/configuracoes_repository.dart';

import '../../domain/models/api/nuvem_fiscal/autenticacao/access_token_model.dart';

Future<void> refreshToken() async {
  AccessTokenRepository accessTokenRepository = AccessTokenRepository();
  AccessTokenModel accessTokenModel = await accessTokenRepository.getAccessToken();
  ConfiguracoesSharedModel configuracoesModel = Get.find<ConfiguracoesSharedModel>();
  configuracoesModel.accessToken = accessTokenModel;
  Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);
  Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
}
