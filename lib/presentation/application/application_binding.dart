import 'package:get/get.dart';
import 'package:paygo_app/presentation/application/application_controller.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ApplicationController>(
      ApplicationController(),
      permanent: false,
    );
  }
}
