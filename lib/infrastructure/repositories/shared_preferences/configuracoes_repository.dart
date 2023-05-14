import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/services/shared_preferences/configuracoes_service.dart';

class ConfiguracoesRepository {
  final ConfiguracoesService _sharedConfiguration = ConfiguracoesService();

  Future<ConfiguracoesSharedModel> getConfiguration() async {
    final String configuration = await _sharedConfiguration.getConfiguration();

    if (configuration.isEmpty) {
      return ConfiguracoesSharedModel();
    }

    return ConfiguracoesSharedModel.fromJson(configuration);
  }

  Future<void> setConfiguration(ConfiguracoesSharedModel configuration) async {
    await _sharedConfiguration.setConfiguration(configuration.toJson());
  }
}
