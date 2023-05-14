import 'package:get/get.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_item_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/inutilizacao_entity.dart';

import '../../../services/database/paygo_sqlite/entities/bandeira_cartao_entity.dart';
import '../../../services/database/paygo_sqlite/entities/configuracoes_entity.dart';
import '../../../services/database/paygo_sqlite/entities/destinatario_entity.dart';
import '../../../services/database/paygo_sqlite/entities/emitente_entity.dart';
import '../../../services/database/paygo_sqlite/entities/forma_pagamento_entity.dart';
import '../../../services/database/paygo_sqlite/entities/produto_entity.dart';
import '../../../services/database/paygo_sqlite/entities/uf_entity.dart';
import '../../../services/database/paygo_sqlite/entities/unidade_medida_entity.dart';
import '../../../services/database/paygo_sqlite/entities/usuario_entity.dart';
import '../../../services/database/paygo_sqlite/service/paygo_sqlite_service.dart';

part 'paygo_database_repository_private.dart';

class PaygoDatabaseRepository {
  final IBandeiraCartaoRepository _bandeiraCartaoRepository = _BandeiraCartaoRepository();
  final IConfiguracoesRepository _configuracoesRepository = _ConfiguracoesRepository();
  final IDestinatarioRepository _destinatarioRepository = _DestinatarioRepository();
  final IEmitenteRepository _emitenteRepository = _EmitenteRepository();
  final IFormaPagamentoRepository _formaPagamentoRepository = _FormaPagamentoRepository();
  final IProdutoRepository _produtoRepository = _ProdutoRepository();
  final IUfRepository _ufRepository = _UfRepository();
  final IUnidadeMedidaRepository _unidadeMedidaRepository = _UnidadeMedidaRepository();
  final IUsuarioRepository _usuarioRepository = _UsuarioRepository();
  final IDocumentoNfceRepository _documentoNFCERepository = _DocumentoNfceRepository();
  final IDocumentoNfceItemRepository _documentoNFCeItemRepository = _DocumentoNfceItemRepository();
  final IDocumentoNfcePagamentoRepository _documentoNFCePagamentoRepository = _DocumentoNfcePagamentoRepository();
  final IInutilizacaoRepository _inutilizacaoRepository = _InutilizacaoRepository();

  IBandeiraCartaoRepository get bandeiraCartao => _bandeiraCartaoRepository;
  IConfiguracoesRepository get configuracoes => _configuracoesRepository;
  IDestinatarioRepository get destinatario => _destinatarioRepository;
  IEmitenteRepository get emitente => _emitenteRepository;
  IFormaPagamentoRepository get formaPagamento => _formaPagamentoRepository;
  IProdutoRepository get produto => _produtoRepository;
  IUfRepository get uf => _ufRepository;
  IUnidadeMedidaRepository get unidadeMedida => _unidadeMedidaRepository;
  IUsuarioRepository get usuario => _usuarioRepository;
  IDocumentoNfceRepository get documentoNFCE => _documentoNFCERepository;
  IDocumentoNfceItemRepository get documentoNFCeItem => _documentoNFCeItemRepository;
  IDocumentoNfcePagamentoRepository get documentoNFCePagamento => _documentoNFCePagamentoRepository;
  IInutilizacaoRepository get inutilizacao => _inutilizacaoRepository;
}
