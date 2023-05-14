import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/inutilizacao/inutilizacao_controller.dart';

class InutilizacaoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<InutilizacaoController>(
      InutilizacaoController(),
      permanent: false,
    );
  }
}
