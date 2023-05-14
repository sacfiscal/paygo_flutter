import 'package:get/get.dart';

import 'empresa_controller.dart';

class EmpresaBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EmpresaController>(
      EmpresaController(),
      permanent: false,
    );
  }
}
