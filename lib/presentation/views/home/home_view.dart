import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/domain/models/shared_preferences/configuracoes_shared_model.dart';
import 'package:paygo_app/infrastructure/routes/navigation_pages.dart';

import 'package:paygo_app/presentation/views/home/home_controller.dart';

import '../../../commons/functions/funcoes_gerais.dart';

class HomeView extends StatefulWidget {
  final String title = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  HomeController controller = Get.find<HomeController>();

  List<Map<String, dynamic>> listViewItens = [
    {
      'label': 'Empresa',
      'sublabel': 'Configurações do Emitente',
      'icon': FaIcon(
        FontAwesomeIcons.building,
        size: 30,
      ),
      'route': NavigationRoutes.empresa,
    },
    {
      'label': 'Clientes',
      'sublabel': 'Cadastro de Clientes',
      'icon': FaIcon(
        FontAwesomeIcons.peopleGroup,
        size: 30,
      ),
      'route': NavigationRoutes.clientes,
    },
    {
      'label': 'Produtos',
      'sublabel': 'Cadastro de Produtos',
      'icon': FaIcon(
        FontAwesomeIcons.box,
        size: 30,
      ),
      'route': NavigationRoutes.produtos,
    },
    {
      'label': 'Unidades',
      'sublabel': 'Cadastro de Unidades',
      'icon': FaIcon(
        FontAwesomeIcons.scaleBalanced,
        size: 30,
      ),
      'route': NavigationRoutes.unidades,
    },
    {
      'label': 'Forma de Pagamento',
      'sublabel': 'Cadastro de Formas de Pagamento',
      'icon': FaIcon(
        FontAwesomeIcons.creditCard,
        size: 30,
      ),
      'route': NavigationRoutes.formaPagamento,
    },
    {
      'label': 'Usuários',
      'sublabel': 'Cadastro de Usuários',
      'icon': FaIcon(
        FontAwesomeIcons.user,
        size: 30,
      ),
      'route': NavigationRoutes.usuarios,
    },
    {
      'label': 'Vendas',
      'sublabel': 'Realizar uma venda',
      'icon': FaIcon(
        FontAwesomeIcons.cartShopping,
        size: 30,
      ),
      'route': NavigationRoutes.vendas,
    },
    {
      'label': 'Inutilização',
      'sublabel': 'Inutilizar Sequencia de Numeração',
      'icon': FaIcon(
        FontAwesomeIcons.deleteLeft,
        size: 30,
      ),
      'route': NavigationRoutes.inutilizacao,
    },
  ];

  @override
  Widget build(BuildContext context) {
    cancelFocus(context);

    return KeyboardDismisser(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                child: AppBar(
                  backgroundColor: ApplicationColors.paygoDark,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  flexibleSpace: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 3, 16, 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 50,
                                    color: ApplicationColors.paygoDark,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Obx(() {
                                  return Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Olá ${Get.find<ConfiguracoesSharedModel>().login},',
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 18,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          'Ambiente de ${controller.ambiente}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.toNamed(NavigationRoutes.configuracoes);
                                },
                                icon: Icon(
                                  Icons.settings,
                                  size: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: ListView.separated(
                      itemCount: listViewItens.length,
                      physics: BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 1,
                          color: ApplicationColors.paygoZinc[400]!,
                        );
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(listViewItens[index]['route']);
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            leading: SizedBox(
                              width: 45,
                              child: Center(
                                child: listViewItens[index]['icon'],
                              ),
                            ),
                            title: Text(
                              listViewItens[index]['label'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              listViewItens[index]['sublabel'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[800],
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/Logo_SACFiscal_vazada1.png',
                        width: 65,
                        height: 65,
                      ),
                      Image.asset(
                        'assets/images/logo/logo_paygo_transparente.png',
                        width: 65,
                        height: 65,
                      ),
                      Image.asset(
                        'assets/images/logo/logo_nuvem_fiscal_transparente.png',
                        width: 65,
                        height: 65,
                      ),
                    ],
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: ApplicationColors.paygoDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 6),
                      child: SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: controller.sair,
                          child: const Text(
                            'Sair',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: ApplicationColors.paygoDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
