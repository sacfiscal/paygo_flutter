// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesService {
  Future<String> getConfiguration() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('configuration') ?? '';
  }

  Future<void> setConfiguration(String configuration) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('configuration', configuration);
  }
}
