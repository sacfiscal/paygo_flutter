import 'package:get/get.dart';

import 'usuario_controller.dart';

class UsuarioBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UsuarioController>(
      UsuarioController(),
      permanent: false,
    );
  }
}
