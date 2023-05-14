import 'package:get/get.dart';

import 'forma_pagamento_controller.dart';

class FormaPagamentoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FormaPagamentoController>(
      FormaPagamentoController(),
      permanent: false,
    );
  }
}
