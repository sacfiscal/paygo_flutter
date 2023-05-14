// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:paygo_app/commons/constantes/paygo_config.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/dao/emitente_dao.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/dao/inutilizacao_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/bandeira_cartao_dao.dart';
import '../dao/configuracoes_dao.dart';
import '../dao/destinatario_dao.dart';
import '../dao/documento_nfce_dao.dart';
import '../dao/documento_nfce_item_dao.dart';
import '../dao/documento_nfce_pagamento_dao.dart';
import '../dao/forma_pagamento_dao.dart';
import '../dao/produto_dao.dart';
import '../dao/uf_dao.dart';
import '../dao/unidade_medida_dao.dart';
import '../dao/usuario_dao.dart';
import '../entities/bandeira_cartao_entity.dart';
import '../entities/configuracoes_entity.dart';
import '../entities/destinatario_entity.dart';
import '../entities/documento_nfce_entity.dart';
import '../entities/documento_nfce_item_entity.dart';
import '../entities/documento_nfce_pagamento_entity.dart';
import '../entities/emitente_entity.dart';
import '../entities/forma_pagamento_entity.dart';
import '../entities/inutilizacao_entity.dart';
import '../entities/produto_entity.dart';
import '../entities/uf_entity.dart';
import '../entities/unidade_medida_entity.dart';
import '../entities/usuario_entity.dart';

part 'paygo_sqlite_service.g.dart'; // the generated code will be there

@Database(
  version: PaygoConfig.databaseVersion,
  entities: [
    BandeiraCartaoEntity,
    ConfiguracoesEntity,
    DestinatarioEntity,
    EmitenteEntity,
    DocumentoNfceEntity,
    DocumentoNfceItemEntity,
    DocumentoNfcePagamentoEntity,
    FormaPagamentoEntity,
    InutilizacaoEntity,
    ProdutoEntity,
    UfEntity,
    UnidadeMedidaEntity,
    UsuarioEntity,
  ],
)
abstract class PayGoSqliteService extends FloorDatabase {
  BandeiraCartaoDao get bandeiraCartaoDao;
  ConfiguracoesDao get configuracoesDao;
  DestinatarioDao get destinatarioDao;
  DocumentoNfceDao get documentoNfceDao;
  DocumentoNfceItemDao get documentoNfceItemDao;
  DocumentoNfcePagamentoDao get documentoNfcePagamentoDao;
  EmitenteDao get emitenteDao;
  FormaPagamentoDao get formaPagamentoDao;
  InutilizacaoDao get inutilizacaoDao;
  ProdutoDao get produtoDao;
  UfDao get ufDao;
  UnidadeMedidaDao get unidadeMedidaDao;
  UsuarioDao get usuarioDao;
}
