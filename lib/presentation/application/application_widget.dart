import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paygo_app/commons/style/application_style.dart';
import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';
import 'package:paygo_app/presentation/application/application_binding.dart';

class ApplicationWidget extends StatefulWidget {
  final String title = 'ApplicationWidget';

  const ApplicationWidget({Key? key}) : super(key: key);

  @override
  ApplicationWidgetState createState() => ApplicationWidgetState();
}

class ApplicationWidgetState extends State<ApplicationWidget> {
  String initialRoute = NavigationPages.initialRoute;

  ConfiguracoesSharedModel configuracoes = Get.find<ConfiguracoesSharedModel>();

  @override
  void initState() {
    super.initState();
  }

  String get getIntialRoute {
    if (configuracoes.empresaIdentificada == true) {
      if (configuracoes.appLogado == true) {
        return NavigationRoutes.homeV3;
      } else {
        return NavigationRoutes.login;
      }
    } else {
      return NavigationRoutes.registro;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: widget.title,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      navigatorObservers: [
        Get.find<RouteObserver>(),
      ],
      theme: ApplicatioStyle.getTheme(StyleType.paygoLight),
      initialBinding: ApplicationBinding(),
      getPages: NavigationPages.data,
      initialRoute: getIntialRoute,
    );
  }
}
