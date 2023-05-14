import 'package:get/get.dart';

import 'produto_controller.dart';

class ProdutoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProdutoController>(
      ProdutoController(),
      permanent: false,
    );
  }
}
