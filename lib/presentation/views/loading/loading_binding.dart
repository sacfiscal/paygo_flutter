import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/loading/loading_controller.dart';

class LoadingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoadingController>(
      LoadingController(),
      permanent: false,
    );
  }
}
