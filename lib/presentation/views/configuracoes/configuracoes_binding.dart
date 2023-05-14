import 'package:get/get.dart';

import 'configuracoes_controller.dart';

class ConfiguracoesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ConfiguracoesController>(
      ConfiguracoesController(),
      permanent: false,
    );
  }
}
