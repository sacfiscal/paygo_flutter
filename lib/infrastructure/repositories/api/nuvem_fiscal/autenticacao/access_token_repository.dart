import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../domain/models/api/nuvem_fiscal/autenticacao/access_token_model.dart';
import '../../../../services/api/nuvem_fiscal/autenticacao/service/autenticacao_service.dart';

class AccessTokenRepository {
  Future<AccessTokenModel> getAccessToken() async {
    final response = await Get.find<AutenticacaoService>().getAccessToken();

    Get.find<Logger>().i('\nObtendo o Token de Autenticação da API\n\n ${response.toString()}');

    return AccessTokenModel.fromMap(json.decode(response));
  }
}
