import 'package:get/get.dart';
import 'package:paygo_app/presentation/views/forma_pagamento/forma_pagamento_cadastro_view.dart';
import 'package:paygo_app/presentation/views/produto/produto_cadastro_view.dart';
import 'package:paygo_app/presentation/views/unidade/unidade_cadastro_view.dart';
import 'package:paygo_app/presentation/views/usuario/usuario_cadastro_view.dart';
import 'package:paygo_app/presentation/views/venda/venda_pagamento_view.dart';
import 'package:paygo_app/presentation/views/venda/venda_cadastro_view.dart';

import '../../presentation/views/cliente/cliente_binding.dart';
import '../../presentation/views/cliente/cliente_cadastro_view.dart';
import '../../presentation/views/cliente/cliente_view.dart';
import '../../presentation/views/configuracoes/configuracoes_binding.dart';
import '../../presentation/views/configuracoes/configuracoes_view.dart';
import '../../presentation/views/empresa/empresa_binding.dart';
import '../../presentation/views/empresa/empresa_view.dart';
import '../../presentation/views/forma_pagamento/forma_pagamento_binding.dart';
import '../../presentation/views/forma_pagamento/forma_pagamento_view.dart';
import '../../presentation/views/home/home_binding.dart';
import '../../presentation/views/home/home_view.dart';
import '../../presentation/views/inutilizacao/inutilizacao_binding.dart';
import '../../presentation/views/inutilizacao/inutilizacao_cadastro_view.dart';
import '../../presentation/views/inutilizacao/inutilizacao_view.dart';
import '../../presentation/views/loading/loading_binding.dart';
import '../../presentation/views/loading/loading_view.dart';
import '../../presentation/views/login/login_binding.dart';
import '../../presentation/views/login/login_view.dart';
import '../../presentation/views/produto/produto_binding.dart';
import '../../presentation/views/produto/produto_view.dart';
import '../../presentation/views/registro/registro_binding.dart';
import '../../presentation/views/registro/registro_view.dart';
import '../../presentation/views/unidade/unidade_binding.dart';
import '../../presentation/views/unidade/unidade_view.dart';
import '../../presentation/views/usuario/usuario_binding.dart';
import '../../presentation/views/usuario/usuario_view.dart';
import '../../presentation/views/venda/venda_binding.dart';
import '../../presentation/views/venda/venda_view.dart';

part 'navigation_routes.dart';

class NavigationPages {
  static const initialRoute = NavigationRoutes.homeV1;

  static final data = [
    GetPage(
      name: NavigationRoutes.loading,
      page: () => LoadingView(
        duration: Get.arguments?['duration'] ?? Duration(seconds: 1),
        nextRoute: Get.arguments?['nextRoute'] ?? '',
        loadingActionMode: Get.arguments?['loadingActionMode'] ?? '',
        loadingActionFunction: Get.arguments?['loadingActionFunction'],
      ),
      bindings: [
        LoadingBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.registro,
      page: () => const RegistroView(),
      bindings: [
        RegistroBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.login,
      page: () => const LoginView(),
      bindings: [
        LoginBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.homeV3,
      page: () => const HomeView(),
      bindings: [
        HomeBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.empresa,
      page: () => const EmpresaView(),
      bindings: [
        EmpresaBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.clientes,
      page: () => const ClienteView(),
      bindings: [
        ClienteBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.clientesCadastro,
      page: () => const ClienteCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.produtos,
      page: () => const ProdutoView(),
      bindings: [
        ProdutoBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.produtosCadastro,
      page: () => const ProdutoCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.unidades,
      page: () => const UnidadeView(),
      bindings: [
        UnidadeBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.unidadesCadastro,
      page: () => const UnidadeCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.formaPagamento,
      page: () => const FormaPagamentoView(),
      bindings: [
        FormaPagamentoBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.formaPagamentoCadastro,
      page: () => const FormaPagamentoCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.configuracoes,
      page: () => const ConfiguracoesView(),
      bindings: [
        ConfiguracoesBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.usuarios,
      page: () => const UsuarioView(),
      bindings: [
        UsuarioBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.usuariosCadastro,
      page: () => const UsuarioCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.vendas,
      page: () => const VendaView(),
      bindings: [
        VendaBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.vendasCadastro,
      page: () => const VendaCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.inutilizacao,
      page: () => const InutilizacaoView(),
      bindings: [
        InutilizacaoBinding(),
      ],
    ),
    GetPage(
      name: NavigationRoutes.inutilizacaoCadastro,
      page: () => const InutilizacaoCadastroView(),
    ),
    GetPage(
      name: NavigationRoutes.vendasPagamento,
      page: () => const VendasPagamentoView(),
    ),
  ];
}
