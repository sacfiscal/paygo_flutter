import 'package:get/get.dart';

import 'venda_controller.dart';

class VendaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<VendaController>(
      VendaController(),
      permanent: false,
    );
  }
}
