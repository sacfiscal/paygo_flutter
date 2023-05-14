import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/registro/registro_controller.dart';

class RegistroBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RegistroController>(
      RegistroController(),
      permanent: false,
    );
  }
}
