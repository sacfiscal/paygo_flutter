import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: false,
    );
  }
}
