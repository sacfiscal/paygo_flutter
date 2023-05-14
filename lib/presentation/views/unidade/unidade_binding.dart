import 'package:get/get.dart';

import 'unidade_controller.dart';

class UnidadeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnidadeController>(
      UnidadeController(),
      permanent: false,
    );
  }
}
