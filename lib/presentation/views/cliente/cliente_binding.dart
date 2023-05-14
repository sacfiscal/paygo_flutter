import 'package:get/get.dart';

import 'cliente_controller.dart';

class ClienteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ClienteController>(
      ClienteController(),
      permanent: false,
    );
  }
}
