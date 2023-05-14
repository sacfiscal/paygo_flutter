import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
      LoginController(),
      permanent: false,
    );
  }
}
