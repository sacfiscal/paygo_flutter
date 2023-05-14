import 'package:get/get.dart';

class LoadingController extends GetxController {
  final _isLoading = true.obs;
  final _loadingText = 'loading'.obs;
  final _status = true.obs;

  bool get isLoading => _isLoading.value;

  String get loadingText => _loadingText.value;
  set loadingText(String value) => _loadingText.value = value;

  bool get status => _status.value;
  set status(bool value) => _status.value = value;

  void setLoading(bool value) {
    _isLoading.value = value;
  }

  void setLoadingText(
    String value,
    bool isLoading,
    bool status,
  ) {
    _loadingText.value = value;
    _isLoading.value = isLoading;
    _status.value = status;
  }
}
