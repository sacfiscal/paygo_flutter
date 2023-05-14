// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'paygo_sqlite_service.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPayGoSqliteService {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PayGoSqliteServiceBuilder databaseBuilder(String name) => _$PayGoSqliteServiceBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PayGoSqliteServiceBuilder inMemoryDatabaseBuilder() => _$PayGoSqliteServiceBuilder(null);
}

class _$PayGoSqliteServiceBuilder {
  _$PayGoSqliteServiceBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PayGoSqliteServiceBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PayGoSqliteServiceBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PayGoSqliteService> build() async {
    final path = name != null ? await sqfliteDatabaseFactory.getDatabasePath(name!) : ':memory:';
    final database = _$PayGoSqliteService();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PayGoSqliteService extends PayGoSqliteService {
  _$PayGoSqliteService([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BandeiraCartaoDao? _bandeiraCartaoDaoInstance;

  ConfiguracoesDao? _configuracoesDaoInstance;

  DestinatarioDao? _destinatarioDaoInstance;

  DocumentoNfceDao? _documentoNfceDaoInstance;

  DocumentoNfceItemDao? _documentoNfceItemDaoInstance;

  DocumentoNfcePagamentoDao? _documentoNfcePagamentoDaoInstance;

  EmitenteDao? _emitenteDaoInstance;

  FormaPagamentoDao? _formaPagamentoDaoInstance;

  InutilizacaoDao? _inutilizacaoDaoInstance;

  ProdutoDao? _produtoDaoInstance;

  UfDao? _ufDaoInstance;

  UnidadeMedidaDao? _unidadeMedidaDaoInstance;

  UsuarioDao? _usuarioDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `bandeiraCartao` (`id` INTEGER, `emitenteId` INTEGER, `codSefaz` TEXT, `descricao` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `configuracoes` (`id` INTEGER, `emitenteId` INTEGER, `serieNfce` TEXT, `ultimaNfce` INTEGER, `arquivoCertificado` TEXT, `ambiente` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `destinatario` (`id` INTEGER, `emitenteId` INTEGER, `cnpjCpf` TEXT, `idEstrangeiro` TEXT, `razaoSocial` TEXT, `nomeFantasia` TEXT, `logradouro` TEXT, `numero` TEXT, `complemento` TEXT, `bairro` TEXT, `codigoMunicipio` TEXT, `municipio` TEXT, `uf` TEXT, `cep` TEXT, `fone` TEXT, `indIeDest` TEXT, `ie` TEXT, `email` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `emitente` (`id` INTEGER, `razaoSocial` TEXT, `nomeFantasia` TEXT, `cnpjCpf` TEXT, `logradouro` TEXT, `numero` TEXT, `complemento` TEXT, `bairro` TEXT, `codigoMunicipio` TEXT, `municipio` TEXT, `uf` TEXT, `cep` TEXT, `fone` TEXT, `ie` TEXT, `crt` TEXT, `idCsc` TEXT, `csc` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `documentoNfce` (`id` INTEGER, `situacao` INTEGER, `emitenteId` INTEGER, `destinatarioId` INTEGER, `destinatarioRazaoSocial` TEXT, `destinatarioCnpjCpf` TEXT, `cnpjCpf` TEXT, `mod` INTEGER, `serie` INTEGER, `nNF` INTEGER, `dhEmi` TEXT, `tpImp` INTEGER, `tpEmis` INTEGER, `tpAmb` INTEGER, `finNFe` INTEGER, `indFinal` INTEGER, `indPres` INTEGER, `vProd` REAL, `vFrete` REAL, `vSeg` REAL, `vDesc` REAL, `vOutro` REAL, `vNF` REAL, `dhCont` TEXT, `xJust` TEXT, `cStat` INTEGER, `xMotivo` TEXT, `dhAutorizacao` TEXT, `protocoloAutorizacao` TEXT, `jsonAutorizacao` TEXT, `escpos` TEXT, `justificativa` TEXT, `dhCancelamento` TEXT, `protocoloCancelamento` TEXT, `jsonCancelamento` TEXT, `idUnico` TEXT, `chNFe` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `documentoNfceItem` (`id` INTEGER, `emitenteId` INTEGER, `documentoId` INTEGER, `produtoId` INTEGER, `cProd` INTEGER, `produtoDescricao` TEXT, `uCom` TEXT, `qCom` REAL, `vUnCom` REAL, `vProd` REAL, `vFrete` REAL, `vSeg` REAL, `vDesc` REAL, `vOutro` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `documentoNfcePagamento` (`id` INTEGER, `emitenteId` INTEGER, `documentoId` INTEGER, `indPag` INTEGER, `tPag` TEXT, `vPag` REAL, `descricaoPagamento` TEXT, `tpIntegra` INTEGER, `cnpj` TEXT, `tBand` INTEGER, `cAut` TEXT, `transactionResult` TEXT, `amount` TEXT, `installments` INTEGER, `currencyCode` TEXT, `requiresConfirmation` TEXT, `confirmationTransactionId` TEXT, `transactionNsu` TEXT, `authorizationCode` TEXT, `transactionId` TEXT, `providerName` TEXT, `cardType` TEXT, `maskedPan` TEXT, `cardName` TEXT, `defaultCardName` TEXT, `cardholderName` TEXT, `resultMessage` TEXT, `fullReceipt` TEXT, `merchantReceipt` TEXT, `cardholderReceipt` TEXT, `shortReceipt` TEXT, `graphicReceiptExists` TEXT, `merchantGraphicReceipt` TEXT, `cardholderGraphicReceipt` TEXT, `paymentMode` TEXT, `uniqueId` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `formaPagto` (`id` INTEGER, `emitenteId` INTEGER, `codSefaz` TEXT, `descricao` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `inutilizacao` (`id` INTEGER, `emitenteId` INTEGER, `tpAmb` INTEGER, `serie` INTEGER, `numeroInicial` INTEGER, `numeroFinal` INTEGER, `justificativa` TEXT, `dhInutilizacao` TEXT, `protocoloInutilizacao` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `produto` (`id` INTEGER, `emitenteId` INTEGER, `codigo` TEXT, `cean` TEXT, `cbarra` TEXT, `descricao` TEXT, `ncm` TEXT, `cest` TEXT, `cfop` INTEGER, `unidade` TEXT, `valor` REAL, `codigoAnp` TEXT, `origem` TEXT, `cstIcms` TEXT, `cstpiscofins` TEXT, `ativo` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `uf` (`id` INTEGER, `emitenteId` INTEGER, `nome` TEXT, `codigoIbge` INTEGER, `sigla` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `unidadeMedida` (`id` INTEGER, `emitenteId` INTEGER, `sigla` TEXT, `descricao` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usuario` (`id` INTEGER, `emitenteId` INTEGER, `nome` TEXT, `login` TEXT, `senha` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BandeiraCartaoDao get bandeiraCartaoDao {
    return _bandeiraCartaoDaoInstance ??= _$BandeiraCartaoDao(database, changeListener);
  }

  @override
  ConfiguracoesDao get configuracoesDao {
    return _configuracoesDaoInstance ??= _$ConfiguracoesDao(database, changeListener);
  }

  @override
  DestinatarioDao get destinatarioDao {
    return _destinatarioDaoInstance ??= _$DestinatarioDao(database, changeListener);
  }

  @override
  DocumentoNfceDao get documentoNfceDao {
    return _documentoNfceDaoInstance ??= _$DocumentoNfceDao(database, changeListener);
  }

  @override
  DocumentoNfceItemDao get documentoNfceItemDao {
    return _documentoNfceItemDaoInstance ??= _$DocumentoNfceItemDao(database, changeListener);
  }

  @override
  DocumentoNfcePagamentoDao get documentoNfcePagamentoDao {
    return _documentoNfcePagamentoDaoInstance ??= _$DocumentoNfcePagamentoDao(database, changeListener);
  }

  @override
  EmitenteDao get emitenteDao {
    return _emitenteDaoInstance ??= _$EmitenteDao(database, changeListener);
  }

  @override
  FormaPagamentoDao get formaPagamentoDao {
    return _formaPagamentoDaoInstance ??= _$FormaPagamentoDao(database, changeListener);
  }

  @override
  InutilizacaoDao get inutilizacaoDao {
    return _inutilizacaoDaoInstance ??= _$InutilizacaoDao(database, changeListener);
  }

  @override
  ProdutoDao get produtoDao {
    return _produtoDaoInstance ??= _$ProdutoDao(database, changeListener);
  }

  @override
  UfDao get ufDao {
    return _ufDaoInstance ??= _$UfDao(database, changeListener);
  }

  @override
  UnidadeMedidaDao get unidadeMedidaDao {
    return _unidadeMedidaDaoInstance ??= _$UnidadeMedidaDao(database, changeListener);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }
}

class _$BandeiraCartaoDao extends BandeiraCartaoDao {
  _$BandeiraCartaoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bandeiraCartaoEntityInsertionAdapter = InsertionAdapter(
            database,
            'bandeiraCartao',
            (BandeiraCartaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                }),
        _bandeiraCartaoEntityUpdateAdapter = UpdateAdapter(
            database,
            'bandeiraCartao',
            ['id'],
            (BandeiraCartaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                }),
        _bandeiraCartaoEntityDeletionAdapter = DeletionAdapter(
            database,
            'bandeiraCartao',
            ['id'],
            (BandeiraCartaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BandeiraCartaoEntity> _bandeiraCartaoEntityInsertionAdapter;

  final UpdateAdapter<BandeiraCartaoEntity> _bandeiraCartaoEntityUpdateAdapter;

  final DeletionAdapter<BandeiraCartaoEntity> _bandeiraCartaoEntityDeletionAdapter;

  @override
  Future<List<BandeiraCartaoEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from bandeiraCartao',
        mapper: (Map<String, Object?> row) => BandeiraCartaoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?));
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from bandeiraCartao      where bandeiraCartao.id = ?1',
        mapper: (Map<String, Object?> row) => BandeiraCartaoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [id]);
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorCodSefaz(String codSefaz) async {
    return _queryAdapter.query('select *       from bandeiraCartao      where bandeiraCartao.codSefaz = ?1',
        mapper: (Map<String, Object?> row) => BandeiraCartaoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [codSefaz]);
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorDescricao(String descricao) async {
    return _queryAdapter.query(
        'select *       from bandeiraCartao      where bandeiraCartao.descricao = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => BandeiraCartaoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [descricao]);
  }

  @override
  Future<void> insertData(BandeiraCartaoEntity entityInstance) async {
    await _bandeiraCartaoEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<BandeiraCartaoEntity> entityInstance) async {
    await _bandeiraCartaoEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(BandeiraCartaoEntity entityInstance) async {
    await _bandeiraCartaoEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<BandeiraCartaoEntity> entityInstance) async {
    await _bandeiraCartaoEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(BandeiraCartaoEntity entityInstance) async {
    await _bandeiraCartaoEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$ConfiguracoesDao extends ConfiguracoesDao {
  _$ConfiguracoesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _configuracoesEntityInsertionAdapter = InsertionAdapter(
            database,
            'configuracoes',
            (ConfiguracoesEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'serieNfce': item.serieNfce,
                  'ultimaNfce': item.ultimaNfce,
                  'arquivoCertificado': item.arquivoCertificado,
                  'ambiente': item.ambiente
                }),
        _configuracoesEntityUpdateAdapter = UpdateAdapter(
            database,
            'configuracoes',
            ['id'],
            (ConfiguracoesEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'serieNfce': item.serieNfce,
                  'ultimaNfce': item.ultimaNfce,
                  'arquivoCertificado': item.arquivoCertificado,
                  'ambiente': item.ambiente
                }),
        _configuracoesEntityDeletionAdapter = DeletionAdapter(
            database,
            'configuracoes',
            ['id'],
            (ConfiguracoesEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'serieNfce': item.serieNfce,
                  'ultimaNfce': item.ultimaNfce,
                  'arquivoCertificado': item.arquivoCertificado,
                  'ambiente': item.ambiente
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ConfiguracoesEntity> _configuracoesEntityInsertionAdapter;

  final UpdateAdapter<ConfiguracoesEntity> _configuracoesEntityUpdateAdapter;

  final DeletionAdapter<ConfiguracoesEntity> _configuracoesEntityDeletionAdapter;

  @override
  Future<List<ConfiguracoesEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from configuracoes',
        mapper: (Map<String, Object?> row) => ConfiguracoesEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            serieNfce: row['serieNfce'] as String?,
            ultimaNfce: row['ultimaNfce'] as int?,
            arquivoCertificado: row['arquivoCertificado'] as String?,
            ambiente: row['ambiente'] as String?));
  }

  @override
  Future<ConfiguracoesEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from configuracoes      where configuracoes.id = ?1',
        mapper: (Map<String, Object?> row) => ConfiguracoesEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            serieNfce: row['serieNfce'] as String?,
            ultimaNfce: row['ultimaNfce'] as int?,
            arquivoCertificado: row['arquivoCertificado'] as String?,
            ambiente: row['ambiente'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertData(ConfiguracoesEntity entityInstance) async {
    await _configuracoesEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<ConfiguracoesEntity> entityInstance) async {
    await _configuracoesEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(ConfiguracoesEntity entityInstance) async {
    await _configuracoesEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<ConfiguracoesEntity> entityInstance) async {
    await _configuracoesEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(ConfiguracoesEntity entityInstance) async {
    await _configuracoesEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$DestinatarioDao extends DestinatarioDao {
  _$DestinatarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _destinatarioEntityInsertionAdapter = InsertionAdapter(
            database,
            'destinatario',
            (DestinatarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'cnpjCpf': item.cnpjCpf,
                  'idEstrangeiro': item.idEstrangeiro,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'indIeDest': item.indIeDest,
                  'ie': item.ie,
                  'email': item.email
                }),
        _destinatarioEntityUpdateAdapter = UpdateAdapter(
            database,
            'destinatario',
            ['id'],
            (DestinatarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'cnpjCpf': item.cnpjCpf,
                  'idEstrangeiro': item.idEstrangeiro,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'indIeDest': item.indIeDest,
                  'ie': item.ie,
                  'email': item.email
                }),
        _destinatarioEntityDeletionAdapter = DeletionAdapter(
            database,
            'destinatario',
            ['id'],
            (DestinatarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'cnpjCpf': item.cnpjCpf,
                  'idEstrangeiro': item.idEstrangeiro,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'indIeDest': item.indIeDest,
                  'ie': item.ie,
                  'email': item.email
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DestinatarioEntity> _destinatarioEntityInsertionAdapter;

  final UpdateAdapter<DestinatarioEntity> _destinatarioEntityUpdateAdapter;

  final DeletionAdapter<DestinatarioEntity> _destinatarioEntityDeletionAdapter;

  @override
  Future<List<DestinatarioEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from destinatario',
        mapper: (Map<String, Object?> row) => DestinatarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            cnpjCpf: row['cnpjCpf'] as String?,
            idEstrangeiro: row['idEstrangeiro'] as String?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            indIeDest: row['indIeDest'] as String?,
            ie: row['ie'] as String?,
            email: row['email'] as String?));
  }

  @override
  Future<DestinatarioEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from destinatario      where destinatario.id = ?1',
        mapper: (Map<String, Object?> row) => DestinatarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            cnpjCpf: row['cnpjCpf'] as String?,
            idEstrangeiro: row['idEstrangeiro'] as String?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            indIeDest: row['indIeDest'] as String?,
            ie: row['ie'] as String?,
            email: row['email'] as String?),
        arguments: [id]);
  }

  @override
  Future<DestinatarioEntity?> listarPorCnpjCpf(String cnpjCpf) async {
    return _queryAdapter.query('select *       from destinatario      where destinatario.cnpjCpf = ?1',
        mapper: (Map<String, Object?> row) => DestinatarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            cnpjCpf: row['cnpjCpf'] as String?,
            idEstrangeiro: row['idEstrangeiro'] as String?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            indIeDest: row['indIeDest'] as String?,
            ie: row['ie'] as String?,
            email: row['email'] as String?),
        arguments: [cnpjCpf]);
  }

  @override
  Future<DestinatarioEntity?> listarPorRazaoSocial(String razaoSocial) async {
    return _queryAdapter.query(
        'select *       from bandeiraCartao      where bandeiraCartao.razaoSocial = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => DestinatarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            cnpjCpf: row['cnpjCpf'] as String?,
            idEstrangeiro: row['idEstrangeiro'] as String?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            indIeDest: row['indIeDest'] as String?,
            ie: row['ie'] as String?,
            email: row['email'] as String?),
        arguments: [razaoSocial]);
  }

  @override
  Future<void> insertData(DestinatarioEntity entityInstance) async {
    await _destinatarioEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<DestinatarioEntity> entityInstance) async {
    await _destinatarioEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(DestinatarioEntity entityInstance) async {
    await _destinatarioEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<DestinatarioEntity> entityInstance) async {
    await _destinatarioEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(DestinatarioEntity entityInstance) async {
    await _destinatarioEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$DocumentoNfceDao extends DocumentoNfceDao {
  _$DocumentoNfceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _documentoNfceEntityInsertionAdapter = InsertionAdapter(
            database,
            'documentoNfce',
            (DocumentoNfceEntity item) => <String, Object?>{
                  'id': item.id,
                  'situacao': item.situacao,
                  'emitenteId': item.emitenteId,
                  'destinatarioId': item.destinatarioId,
                  'destinatarioRazaoSocial': item.destinatarioRazaoSocial,
                  'destinatarioCnpjCpf': item.destinatarioCnpjCpf,
                  'cnpjCpf': item.cnpjCpf,
                  'mod': item.mod,
                  'serie': item.serie,
                  'nNF': item.nNF,
                  'dhEmi': item.dhEmi,
                  'tpImp': item.tpImp,
                  'tpEmis': item.tpEmis,
                  'tpAmb': item.tpAmb,
                  'finNFe': item.finNFe,
                  'indFinal': item.indFinal,
                  'indPres': item.indPres,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro,
                  'vNF': item.vNF,
                  'dhCont': item.dhCont,
                  'xJust': item.xJust,
                  'cStat': item.cStat,
                  'xMotivo': item.xMotivo,
                  'dhAutorizacao': item.dhAutorizacao,
                  'protocoloAutorizacao': item.protocoloAutorizacao,
                  'jsonAutorizacao': item.jsonAutorizacao,
                  'escpos': item.escpos,
                  'justificativa': item.justificativa,
                  'dhCancelamento': item.dhCancelamento,
                  'protocoloCancelamento': item.protocoloCancelamento,
                  'jsonCancelamento': item.jsonCancelamento,
                  'idUnico': item.idUnico,
                  'chNFe': item.chNFe
                }),
        _documentoNfceEntityUpdateAdapter = UpdateAdapter(
            database,
            'documentoNfce',
            ['id'],
            (DocumentoNfceEntity item) => <String, Object?>{
                  'id': item.id,
                  'situacao': item.situacao,
                  'emitenteId': item.emitenteId,
                  'destinatarioId': item.destinatarioId,
                  'destinatarioRazaoSocial': item.destinatarioRazaoSocial,
                  'destinatarioCnpjCpf': item.destinatarioCnpjCpf,
                  'cnpjCpf': item.cnpjCpf,
                  'mod': item.mod,
                  'serie': item.serie,
                  'nNF': item.nNF,
                  'dhEmi': item.dhEmi,
                  'tpImp': item.tpImp,
                  'tpEmis': item.tpEmis,
                  'tpAmb': item.tpAmb,
                  'finNFe': item.finNFe,
                  'indFinal': item.indFinal,
                  'indPres': item.indPres,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro,
                  'vNF': item.vNF,
                  'dhCont': item.dhCont,
                  'xJust': item.xJust,
                  'cStat': item.cStat,
                  'xMotivo': item.xMotivo,
                  'dhAutorizacao': item.dhAutorizacao,
                  'protocoloAutorizacao': item.protocoloAutorizacao,
                  'jsonAutorizacao': item.jsonAutorizacao,
                  'escpos': item.escpos,
                  'justificativa': item.justificativa,
                  'dhCancelamento': item.dhCancelamento,
                  'protocoloCancelamento': item.protocoloCancelamento,
                  'jsonCancelamento': item.jsonCancelamento,
                  'idUnico': item.idUnico,
                  'chNFe': item.chNFe
                }),
        _documentoNfceEntityDeletionAdapter = DeletionAdapter(
            database,
            'documentoNfce',
            ['id'],
            (DocumentoNfceEntity item) => <String, Object?>{
                  'id': item.id,
                  'situacao': item.situacao,
                  'emitenteId': item.emitenteId,
                  'destinatarioId': item.destinatarioId,
                  'destinatarioRazaoSocial': item.destinatarioRazaoSocial,
                  'destinatarioCnpjCpf': item.destinatarioCnpjCpf,
                  'cnpjCpf': item.cnpjCpf,
                  'mod': item.mod,
                  'serie': item.serie,
                  'nNF': item.nNF,
                  'dhEmi': item.dhEmi,
                  'tpImp': item.tpImp,
                  'tpEmis': item.tpEmis,
                  'tpAmb': item.tpAmb,
                  'finNFe': item.finNFe,
                  'indFinal': item.indFinal,
                  'indPres': item.indPres,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro,
                  'vNF': item.vNF,
                  'dhCont': item.dhCont,
                  'xJust': item.xJust,
                  'cStat': item.cStat,
                  'xMotivo': item.xMotivo,
                  'dhAutorizacao': item.dhAutorizacao,
                  'protocoloAutorizacao': item.protocoloAutorizacao,
                  'jsonAutorizacao': item.jsonAutorizacao,
                  'escpos': item.escpos,
                  'justificativa': item.justificativa,
                  'dhCancelamento': item.dhCancelamento,
                  'protocoloCancelamento': item.protocoloCancelamento,
                  'jsonCancelamento': item.jsonCancelamento,
                  'idUnico': item.idUnico,
                  'chNFe': item.chNFe
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DocumentoNfceEntity> _documentoNfceEntityInsertionAdapter;

  final UpdateAdapter<DocumentoNfceEntity> _documentoNfceEntityUpdateAdapter;

  final DeletionAdapter<DocumentoNfceEntity> _documentoNfceEntityDeletionAdapter;

  @override
  Future<List<DocumentoNfceEntity>?> listar(int tpAmb) async {
    return _queryAdapter.queryList(
        'select documentoNfce.*,            destinatario.razaoSocial as destinatarioRazaoSocial,            destinatario.cnpjCpf as destinatarioCnpjCpf       from documentoNfce       left outer join destinatario on ( destinatario.id = documentoNfce.destinatarioId )      where documentoNfce.tpAmb = ?1',
        mapper: (Map<String, Object?> row) => DocumentoNfceEntity(id: row['id'] as int?, situacao: row['situacao'] as int?, emitenteId: row['emitenteId'] as int?, destinatarioId: row['destinatarioId'] as int?, destinatarioRazaoSocial: row['destinatarioRazaoSocial'] as String?, destinatarioCnpjCpf: row['destinatarioCnpjCpf'] as String?, cnpjCpf: row['cnpjCpf'] as String?, mod: row['mod'] as int?, serie: row['serie'] as int?, nNF: row['nNF'] as int?, dhEmi: row['dhEmi'] as String?, tpImp: row['tpImp'] as int?, tpEmis: row['tpEmis'] as int?, tpAmb: row['tpAmb'] as int?, finNFe: row['finNFe'] as int?, indFinal: row['indFinal'] as int?, indPres: row['indPres'] as int?, vProd: row['vProd'] as double?, vFrete: row['vFrete'] as double?, vSeg: row['vSeg'] as double?, vDesc: row['vDesc'] as double?, vOutro: row['vOutro'] as double?, vNF: row['vNF'] as double?, dhCont: row['dhCont'] as String?, xJust: row['xJust'] as String?, cStat: row['cStat'] as int?, xMotivo: row['xMotivo'] as String?, dhAutorizacao: row['dhAutorizacao'] as String?, protocoloAutorizacao: row['protocoloAutorizacao'] as String?, jsonAutorizacao: row['jsonAutorizacao'] as String?, escpos: row['escpos'] as String?, justificativa: row['justificativa'] as String?, dhCancelamento: row['dhCancelamento'] as String?, protocoloCancelamento: row['protocoloCancelamento'] as String?, jsonCancelamento: row['jsonCancelamento'] as String?, idUnico: row['idUnico'] as String?, chNFe: row['chNFe'] as String?),
        arguments: [tpAmb]);
  }

  @override
  Future<DocumentoNfceEntity?> listarPorId(
    int tpAmb,
    int id,
  ) async {
    return _queryAdapter.query(
        'select *       from documentoNfce      where documentoNfce.tpAmb = ?1        and documentoNfce.id = ?2',
        mapper: (Map<String, Object?> row) => DocumentoNfceEntity(
            id: row['id'] as int?,
            situacao: row['situacao'] as int?,
            emitenteId: row['emitenteId'] as int?,
            destinatarioId: row['destinatarioId'] as int?,
            destinatarioRazaoSocial: row['destinatarioRazaoSocial'] as String?,
            destinatarioCnpjCpf: row['destinatarioCnpjCpf'] as String?,
            cnpjCpf: row['cnpjCpf'] as String?,
            mod: row['mod'] as int?,
            serie: row['serie'] as int?,
            nNF: row['nNF'] as int?,
            dhEmi: row['dhEmi'] as String?,
            tpImp: row['tpImp'] as int?,
            tpEmis: row['tpEmis'] as int?,
            tpAmb: row['tpAmb'] as int?,
            finNFe: row['finNFe'] as int?,
            indFinal: row['indFinal'] as int?,
            indPres: row['indPres'] as int?,
            vProd: row['vProd'] as double?,
            vFrete: row['vFrete'] as double?,
            vSeg: row['vSeg'] as double?,
            vDesc: row['vDesc'] as double?,
            vOutro: row['vOutro'] as double?,
            vNF: row['vNF'] as double?,
            dhCont: row['dhCont'] as String?,
            xJust: row['xJust'] as String?,
            cStat: row['cStat'] as int?,
            xMotivo: row['xMotivo'] as String?,
            dhAutorizacao: row['dhAutorizacao'] as String?,
            protocoloAutorizacao: row['protocoloAutorizacao'] as String?,
            jsonAutorizacao: row['jsonAutorizacao'] as String?,
            escpos: row['escpos'] as String?,
            justificativa: row['justificativa'] as String?,
            dhCancelamento: row['dhCancelamento'] as String?,
            protocoloCancelamento: row['protocoloCancelamento'] as String?,
            jsonCancelamento: row['jsonCancelamento'] as String?,
            idUnico: row['idUnico'] as String?,
            chNFe: row['chNFe'] as String?),
        arguments: [tpAmb, id]);
  }

  @override
  Future<DocumentoNfceEntity?> listarPorSerieNf(
    int tpAmb,
    int serie,
    int nNF,
  ) async {
    return _queryAdapter.query(
        'select *       from documentoNfce      where documentoNfce.tpAmb = ?1        and documentoNfce.serie = ?2        and documentoNfce.nNF = ?3',
        mapper: (Map<String, Object?> row) => DocumentoNfceEntity(id: row['id'] as int?, situacao: row['situacao'] as int?, emitenteId: row['emitenteId'] as int?, destinatarioId: row['destinatarioId'] as int?, destinatarioRazaoSocial: row['destinatarioRazaoSocial'] as String?, destinatarioCnpjCpf: row['destinatarioCnpjCpf'] as String?, cnpjCpf: row['cnpjCpf'] as String?, mod: row['mod'] as int?, serie: row['serie'] as int?, nNF: row['nNF'] as int?, dhEmi: row['dhEmi'] as String?, tpImp: row['tpImp'] as int?, tpEmis: row['tpEmis'] as int?, tpAmb: row['tpAmb'] as int?, finNFe: row['finNFe'] as int?, indFinal: row['indFinal'] as int?, indPres: row['indPres'] as int?, vProd: row['vProd'] as double?, vFrete: row['vFrete'] as double?, vSeg: row['vSeg'] as double?, vDesc: row['vDesc'] as double?, vOutro: row['vOutro'] as double?, vNF: row['vNF'] as double?, dhCont: row['dhCont'] as String?, xJust: row['xJust'] as String?, cStat: row['cStat'] as int?, xMotivo: row['xMotivo'] as String?, dhAutorizacao: row['dhAutorizacao'] as String?, protocoloAutorizacao: row['protocoloAutorizacao'] as String?, jsonAutorizacao: row['jsonAutorizacao'] as String?, escpos: row['escpos'] as String?, justificativa: row['justificativa'] as String?, dhCancelamento: row['dhCancelamento'] as String?, protocoloCancelamento: row['protocoloCancelamento'] as String?, jsonCancelamento: row['jsonCancelamento'] as String?, idUnico: row['idUnico'] as String?, chNFe: row['chNFe'] as String?),
        arguments: [tpAmb, serie, nNF]);
  }

  @override
  Future<void> insertData(DocumentoNfceEntity entityInstance) async {
    await _documentoNfceEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<DocumentoNfceEntity> entityInstance) async {
    await _documentoNfceEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(DocumentoNfceEntity entityInstance) async {
    await _documentoNfceEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<DocumentoNfceEntity> entityInstance) async {
    await _documentoNfceEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(DocumentoNfceEntity entityInstance) async {
    await _documentoNfceEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$DocumentoNfceItemDao extends DocumentoNfceItemDao {
  _$DocumentoNfceItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _documentoNfceItemEntityInsertionAdapter = InsertionAdapter(
            database,
            'documentoNfceItem',
            (DocumentoNfceItemEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'produtoId': item.produtoId,
                  'cProd': item.cProd,
                  'produtoDescricao': item.produtoDescricao,
                  'uCom': item.uCom,
                  'qCom': item.qCom,
                  'vUnCom': item.vUnCom,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro
                }),
        _documentoNfceItemEntityUpdateAdapter = UpdateAdapter(
            database,
            'documentoNfceItem',
            ['id'],
            (DocumentoNfceItemEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'produtoId': item.produtoId,
                  'cProd': item.cProd,
                  'produtoDescricao': item.produtoDescricao,
                  'uCom': item.uCom,
                  'qCom': item.qCom,
                  'vUnCom': item.vUnCom,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro
                }),
        _documentoNfceItemEntityDeletionAdapter = DeletionAdapter(
            database,
            'documentoNfceItem',
            ['id'],
            (DocumentoNfceItemEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'produtoId': item.produtoId,
                  'cProd': item.cProd,
                  'produtoDescricao': item.produtoDescricao,
                  'uCom': item.uCom,
                  'qCom': item.qCom,
                  'vUnCom': item.vUnCom,
                  'vProd': item.vProd,
                  'vFrete': item.vFrete,
                  'vSeg': item.vSeg,
                  'vDesc': item.vDesc,
                  'vOutro': item.vOutro
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DocumentoNfceItemEntity> _documentoNfceItemEntityInsertionAdapter;

  final UpdateAdapter<DocumentoNfceItemEntity> _documentoNfceItemEntityUpdateAdapter;

  final DeletionAdapter<DocumentoNfceItemEntity> _documentoNfceItemEntityDeletionAdapter;

  @override
  Future<List<DocumentoNfceItemEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from documentoNfceItem',
        mapper: (Map<String, Object?> row) => DocumentoNfceItemEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            documentoId: row['documentoId'] as int?,
            produtoId: row['produtoId'] as int?,
            cProd: row['cProd'] as int?,
            produtoDescricao: row['produtoDescricao'] as String?,
            uCom: row['uCom'] as String?,
            qCom: row['qCom'] as double?,
            vUnCom: row['vUnCom'] as double?,
            vProd: row['vProd'] as double?,
            vFrete: row['vFrete'] as double?,
            vSeg: row['vSeg'] as double?,
            vDesc: row['vDesc'] as double?,
            vOutro: row['vOutro'] as double?));
  }

  @override
  Future<DocumentoNfceItemEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from documentoNfceItem      where documentoNfceItem.id = ?1',
        mapper: (Map<String, Object?> row) => DocumentoNfceItemEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            documentoId: row['documentoId'] as int?,
            produtoId: row['produtoId'] as int?,
            cProd: row['cProd'] as int?,
            produtoDescricao: row['produtoDescricao'] as String?,
            uCom: row['uCom'] as String?,
            qCom: row['qCom'] as double?,
            vUnCom: row['vUnCom'] as double?,
            vProd: row['vProd'] as double?,
            vFrete: row['vFrete'] as double?,
            vSeg: row['vSeg'] as double?,
            vDesc: row['vDesc'] as double?,
            vOutro: row['vOutro'] as double?),
        arguments: [id]);
  }

  @override
  Future<List<DocumentoNfceItemEntity>?> listarPorIdDocumento(int documentoId) async {
    return _queryAdapter.queryList(
        'select documentoNfceItem.*,            produto.descricao as produtoDescricao       from documentoNfceItem       join produto on produto.id = documentoNfceItem.produtoId      where documentoNfceItem.documentoId = ?1',
        mapper: (Map<String, Object?> row) => DocumentoNfceItemEntity(id: row['id'] as int?, emitenteId: row['emitenteId'] as int?, documentoId: row['documentoId'] as int?, produtoId: row['produtoId'] as int?, cProd: row['cProd'] as int?, produtoDescricao: row['produtoDescricao'] as String?, uCom: row['uCom'] as String?, qCom: row['qCom'] as double?, vUnCom: row['vUnCom'] as double?, vProd: row['vProd'] as double?, vFrete: row['vFrete'] as double?, vSeg: row['vSeg'] as double?, vDesc: row['vDesc'] as double?, vOutro: row['vOutro'] as double?),
        arguments: [documentoId]);
  }

  @override
  Future<void> insertData(DocumentoNfceItemEntity entityInstance) async {
    await _documentoNfceItemEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<DocumentoNfceItemEntity> entityInstance) async {
    await _documentoNfceItemEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(DocumentoNfceItemEntity entityInstance) async {
    await _documentoNfceItemEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<DocumentoNfceItemEntity> entityInstance) async {
    await _documentoNfceItemEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(DocumentoNfceItemEntity entityInstance) async {
    await _documentoNfceItemEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$DocumentoNfcePagamentoDao extends DocumentoNfcePagamentoDao {
  _$DocumentoNfcePagamentoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _documentoNfcePagamentoEntityInsertionAdapter = InsertionAdapter(
            database,
            'documentoNfcePagamento',
            (DocumentoNfcePagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'indPag': item.indPag,
                  'tPag': item.tPag,
                  'vPag': item.vPag,
                  'descricaoPagamento': item.descricaoPagamento,
                  'tpIntegra': item.tpIntegra,
                  'cnpj': item.cnpj,
                  'tBand': item.tBand,
                  'cAut': item.cAut,
                  'transactionResult': item.transactionResult,
                  'amount': item.amount,
                  'installments': item.installments,
                  'currencyCode': item.currencyCode,
                  'requiresConfirmation': item.requiresConfirmation,
                  'confirmationTransactionId': item.confirmationTransactionId,
                  'transactionNsu': item.transactionNsu,
                  'authorizationCode': item.authorizationCode,
                  'transactionId': item.transactionId,
                  'providerName': item.providerName,
                  'cardType': item.cardType,
                  'maskedPan': item.maskedPan,
                  'cardName': item.cardName,
                  'defaultCardName': item.defaultCardName,
                  'cardholderName': item.cardholderName,
                  'resultMessage': item.resultMessage,
                  'fullReceipt': item.fullReceipt,
                  'merchantReceipt': item.merchantReceipt,
                  'cardholderReceipt': item.cardholderReceipt,
                  'shortReceipt': item.shortReceipt,
                  'graphicReceiptExists': item.graphicReceiptExists,
                  'merchantGraphicReceipt': item.merchantGraphicReceipt,
                  'cardholderGraphicReceipt': item.cardholderGraphicReceipt,
                  'paymentMode': item.paymentMode,
                  'uniqueId': item.uniqueId
                }),
        _documentoNfcePagamentoEntityUpdateAdapter = UpdateAdapter(
            database,
            'documentoNfcePagamento',
            ['id'],
            (DocumentoNfcePagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'indPag': item.indPag,
                  'tPag': item.tPag,
                  'vPag': item.vPag,
                  'descricaoPagamento': item.descricaoPagamento,
                  'tpIntegra': item.tpIntegra,
                  'cnpj': item.cnpj,
                  'tBand': item.tBand,
                  'cAut': item.cAut,
                  'transactionResult': item.transactionResult,
                  'amount': item.amount,
                  'installments': item.installments,
                  'currencyCode': item.currencyCode,
                  'requiresConfirmation': item.requiresConfirmation,
                  'confirmationTransactionId': item.confirmationTransactionId,
                  'transactionNsu': item.transactionNsu,
                  'authorizationCode': item.authorizationCode,
                  'transactionId': item.transactionId,
                  'providerName': item.providerName,
                  'cardType': item.cardType,
                  'maskedPan': item.maskedPan,
                  'cardName': item.cardName,
                  'defaultCardName': item.defaultCardName,
                  'cardholderName': item.cardholderName,
                  'resultMessage': item.resultMessage,
                  'fullReceipt': item.fullReceipt,
                  'merchantReceipt': item.merchantReceipt,
                  'cardholderReceipt': item.cardholderReceipt,
                  'shortReceipt': item.shortReceipt,
                  'graphicReceiptExists': item.graphicReceiptExists,
                  'merchantGraphicReceipt': item.merchantGraphicReceipt,
                  'cardholderGraphicReceipt': item.cardholderGraphicReceipt,
                  'paymentMode': item.paymentMode,
                  'uniqueId': item.uniqueId
                }),
        _documentoNfcePagamentoEntityDeletionAdapter = DeletionAdapter(
            database,
            'documentoNfcePagamento',
            ['id'],
            (DocumentoNfcePagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'documentoId': item.documentoId,
                  'indPag': item.indPag,
                  'tPag': item.tPag,
                  'vPag': item.vPag,
                  'descricaoPagamento': item.descricaoPagamento,
                  'tpIntegra': item.tpIntegra,
                  'cnpj': item.cnpj,
                  'tBand': item.tBand,
                  'cAut': item.cAut,
                  'transactionResult': item.transactionResult,
                  'amount': item.amount,
                  'installments': item.installments,
                  'currencyCode': item.currencyCode,
                  'requiresConfirmation': item.requiresConfirmation,
                  'confirmationTransactionId': item.confirmationTransactionId,
                  'transactionNsu': item.transactionNsu,
                  'authorizationCode': item.authorizationCode,
                  'transactionId': item.transactionId,
                  'providerName': item.providerName,
                  'cardType': item.cardType,
                  'maskedPan': item.maskedPan,
                  'cardName': item.cardName,
                  'defaultCardName': item.defaultCardName,
                  'cardholderName': item.cardholderName,
                  'resultMessage': item.resultMessage,
                  'fullReceipt': item.fullReceipt,
                  'merchantReceipt': item.merchantReceipt,
                  'cardholderReceipt': item.cardholderReceipt,
                  'shortReceipt': item.shortReceipt,
                  'graphicReceiptExists': item.graphicReceiptExists,
                  'merchantGraphicReceipt': item.merchantGraphicReceipt,
                  'cardholderGraphicReceipt': item.cardholderGraphicReceipt,
                  'paymentMode': item.paymentMode,
                  'uniqueId': item.uniqueId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DocumentoNfcePagamentoEntity> _documentoNfcePagamentoEntityInsertionAdapter;

  final UpdateAdapter<DocumentoNfcePagamentoEntity> _documentoNfcePagamentoEntityUpdateAdapter;

  final DeletionAdapter<DocumentoNfcePagamentoEntity> _documentoNfcePagamentoEntityDeletionAdapter;

  @override
  Future<List<DocumentoNfcePagamentoEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from documentoNfcePagamento',
        mapper: (Map<String, Object?> row) => DocumentoNfcePagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            documentoId: row['documentoId'] as int?,
            indPag: row['indPag'] as int?,
            tPag: row['tPag'] as String?,
            vPag: row['vPag'] as double?,
            descricaoPagamento: row['descricaoPagamento'] as String?,
            tpIntegra: row['tpIntegra'] as int?,
            cnpj: row['cnpj'] as String?,
            tBand: row['tBand'] as int?,
            cAut: row['cAut'] as String?,
            transactionResult: row['transactionResult'] as String?,
            amount: row['amount'] as String?,
            installments: row['installments'] as int?,
            currencyCode: row['currencyCode'] as String?,
            requiresConfirmation: row['requiresConfirmation'] as String?,
            confirmationTransactionId: row['confirmationTransactionId'] as String?,
            transactionNsu: row['transactionNsu'] as String?,
            authorizationCode: row['authorizationCode'] as String?,
            transactionId: row['transactionId'] as String?,
            providerName: row['providerName'] as String?,
            cardType: row['cardType'] as String?,
            maskedPan: row['maskedPan'] as String?,
            cardName: row['cardName'] as String?,
            defaultCardName: row['defaultCardName'] as String?,
            cardholderName: row['cardholderName'] as String?,
            resultMessage: row['resultMessage'] as String?,
            fullReceipt: row['fullReceipt'] as String?,
            merchantReceipt: row['merchantReceipt'] as String?,
            cardholderReceipt: row['cardholderReceipt'] as String?,
            shortReceipt: row['shortReceipt'] as String?,
            graphicReceiptExists: row['graphicReceiptExists'] as String?,
            merchantGraphicReceipt: row['merchantGraphicReceipt'] as String?,
            cardholderGraphicReceipt: row['cardholderGraphicReceipt'] as String?,
            paymentMode: row['paymentMode'] as String?,
            uniqueId: row['uniqueId'] as String?));
  }

  @override
  Future<DocumentoNfcePagamentoEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from documentoNfcePagamento      where documentoNfcePagamento.id = ?1',
        mapper: (Map<String, Object?> row) => DocumentoNfcePagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            documentoId: row['documentoId'] as int?,
            indPag: row['indPag'] as int?,
            tPag: row['tPag'] as String?,
            vPag: row['vPag'] as double?,
            descricaoPagamento: row['descricaoPagamento'] as String?,
            tpIntegra: row['tpIntegra'] as int?,
            cnpj: row['cnpj'] as String?,
            tBand: row['tBand'] as int?,
            cAut: row['cAut'] as String?,
            transactionResult: row['transactionResult'] as String?,
            amount: row['amount'] as String?,
            installments: row['installments'] as int?,
            currencyCode: row['currencyCode'] as String?,
            requiresConfirmation: row['requiresConfirmation'] as String?,
            confirmationTransactionId: row['confirmationTransactionId'] as String?,
            transactionNsu: row['transactionNsu'] as String?,
            authorizationCode: row['authorizationCode'] as String?,
            transactionId: row['transactionId'] as String?,
            providerName: row['providerName'] as String?,
            cardType: row['cardType'] as String?,
            maskedPan: row['maskedPan'] as String?,
            cardName: row['cardName'] as String?,
            defaultCardName: row['defaultCardName'] as String?,
            cardholderName: row['cardholderName'] as String?,
            resultMessage: row['resultMessage'] as String?,
            fullReceipt: row['fullReceipt'] as String?,
            merchantReceipt: row['merchantReceipt'] as String?,
            cardholderReceipt: row['cardholderReceipt'] as String?,
            shortReceipt: row['shortReceipt'] as String?,
            graphicReceiptExists: row['graphicReceiptExists'] as String?,
            merchantGraphicReceipt: row['merchantGraphicReceipt'] as String?,
            cardholderGraphicReceipt: row['cardholderGraphicReceipt'] as String?,
            paymentMode: row['paymentMode'] as String?,
            uniqueId: row['uniqueId'] as String?),
        arguments: [id]);
  }

  @override
  Future<DocumentoNfcePagamentoEntity?> listarPorIdDocumento(int documentoId) async {
    return _queryAdapter.query(
        'select *       from documentoNfcePagamento      where documentoNfcePagamento.documentoId = ?1',
        mapper: (Map<String, Object?> row) => DocumentoNfcePagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            documentoId: row['documentoId'] as int?,
            indPag: row['indPag'] as int?,
            tPag: row['tPag'] as String?,
            vPag: row['vPag'] as double?,
            descricaoPagamento: row['descricaoPagamento'] as String?,
            tpIntegra: row['tpIntegra'] as int?,
            cnpj: row['cnpj'] as String?,
            tBand: row['tBand'] as int?,
            cAut: row['cAut'] as String?,
            transactionResult: row['transactionResult'] as String?,
            amount: row['amount'] as String?,
            installments: row['installments'] as int?,
            currencyCode: row['currencyCode'] as String?,
            requiresConfirmation: row['requiresConfirmation'] as String?,
            confirmationTransactionId: row['confirmationTransactionId'] as String?,
            transactionNsu: row['transactionNsu'] as String?,
            authorizationCode: row['authorizationCode'] as String?,
            transactionId: row['transactionId'] as String?,
            providerName: row['providerName'] as String?,
            cardType: row['cardType'] as String?,
            maskedPan: row['maskedPan'] as String?,
            cardName: row['cardName'] as String?,
            defaultCardName: row['defaultCardName'] as String?,
            cardholderName: row['cardholderName'] as String?,
            resultMessage: row['resultMessage'] as String?,
            fullReceipt: row['fullReceipt'] as String?,
            merchantReceipt: row['merchantReceipt'] as String?,
            cardholderReceipt: row['cardholderReceipt'] as String?,
            shortReceipt: row['shortReceipt'] as String?,
            graphicReceiptExists: row['graphicReceiptExists'] as String?,
            merchantGraphicReceipt: row['merchantGraphicReceipt'] as String?,
            cardholderGraphicReceipt: row['cardholderGraphicReceipt'] as String?,
            paymentMode: row['paymentMode'] as String?,
            uniqueId: row['uniqueId'] as String?),
        arguments: [documentoId]);
  }

  @override
  Future<void> insertData(DocumentoNfcePagamentoEntity entityInstance) async {
    await _documentoNfcePagamentoEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<DocumentoNfcePagamentoEntity> entityInstance) async {
    await _documentoNfcePagamentoEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(DocumentoNfcePagamentoEntity entityInstance) async {
    await _documentoNfcePagamentoEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<DocumentoNfcePagamentoEntity> entityInstance) async {
    await _documentoNfcePagamentoEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(DocumentoNfcePagamentoEntity entityInstance) async {
    await _documentoNfcePagamentoEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$EmitenteDao extends EmitenteDao {
  _$EmitenteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _emitenteEntityInsertionAdapter = InsertionAdapter(
            database,
            'emitente',
            (EmitenteEntity item) => <String, Object?>{
                  'id': item.id,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'cnpjCpf': item.cnpjCpf,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'ie': item.ie,
                  'crt': item.crt,
                  'idCsc': item.idCsc,
                  'csc': item.csc
                }),
        _emitenteEntityUpdateAdapter = UpdateAdapter(
            database,
            'emitente',
            ['id'],
            (EmitenteEntity item) => <String, Object?>{
                  'id': item.id,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'cnpjCpf': item.cnpjCpf,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'ie': item.ie,
                  'crt': item.crt,
                  'idCsc': item.idCsc,
                  'csc': item.csc
                }),
        _emitenteEntityDeletionAdapter = DeletionAdapter(
            database,
            'emitente',
            ['id'],
            (EmitenteEntity item) => <String, Object?>{
                  'id': item.id,
                  'razaoSocial': item.razaoSocial,
                  'nomeFantasia': item.nomeFantasia,
                  'cnpjCpf': item.cnpjCpf,
                  'logradouro': item.logradouro,
                  'numero': item.numero,
                  'complemento': item.complemento,
                  'bairro': item.bairro,
                  'codigoMunicipio': item.codigoMunicipio,
                  'municipio': item.municipio,
                  'uf': item.uf,
                  'cep': item.cep,
                  'fone': item.fone,
                  'ie': item.ie,
                  'crt': item.crt,
                  'idCsc': item.idCsc,
                  'csc': item.csc
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<EmitenteEntity> _emitenteEntityInsertionAdapter;

  final UpdateAdapter<EmitenteEntity> _emitenteEntityUpdateAdapter;

  final DeletionAdapter<EmitenteEntity> _emitenteEntityDeletionAdapter;

  @override
  Future<List<EmitenteEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from emitente',
        mapper: (Map<String, Object?> row) => EmitenteEntity(
            id: row['id'] as int?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            cnpjCpf: row['cnpjCpf'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            ie: row['ie'] as String?,
            crt: row['crt'] as String?,
            idCsc: row['idCsc'] as String?,
            csc: row['csc'] as String?));
  }

  @override
  Future<EmitenteEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from emitente      where emitente.id = ?1',
        mapper: (Map<String, Object?> row) => EmitenteEntity(
            id: row['id'] as int?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            cnpjCpf: row['cnpjCpf'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            ie: row['ie'] as String?,
            crt: row['crt'] as String?,
            idCsc: row['idCsc'] as String?,
            csc: row['csc'] as String?),
        arguments: [id]);
  }

  @override
  Future<EmitenteEntity?> listarPorCpfCnpj(String cnpjCpf) async {
    return _queryAdapter.query('select *       from emitente      where emitente.cnpjCpf = ?1',
        mapper: (Map<String, Object?> row) => EmitenteEntity(
            id: row['id'] as int?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            cnpjCpf: row['cnpjCpf'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            ie: row['ie'] as String?,
            crt: row['crt'] as String?,
            idCsc: row['idCsc'] as String?,
            csc: row['csc'] as String?),
        arguments: [cnpjCpf]);
  }

  @override
  Future<EmitenteEntity?> listarPorRazaoSocial(String razaoSocial) async {
    return _queryAdapter.query('select *       from emitente      where emitente.razaoSocial = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => EmitenteEntity(
            id: row['id'] as int?,
            razaoSocial: row['razaoSocial'] as String?,
            nomeFantasia: row['nomeFantasia'] as String?,
            cnpjCpf: row['cnpjCpf'] as String?,
            logradouro: row['logradouro'] as String?,
            numero: row['numero'] as String?,
            complemento: row['complemento'] as String?,
            bairro: row['bairro'] as String?,
            codigoMunicipio: row['codigoMunicipio'] as String?,
            municipio: row['municipio'] as String?,
            uf: row['uf'] as String?,
            cep: row['cep'] as String?,
            fone: row['fone'] as String?,
            ie: row['ie'] as String?,
            crt: row['crt'] as String?,
            idCsc: row['idCsc'] as String?,
            csc: row['csc'] as String?),
        arguments: [razaoSocial]);
  }

  @override
  Future<void> insertData(EmitenteEntity entityInstance) async {
    await _emitenteEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<EmitenteEntity> entityInstance) async {
    await _emitenteEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(EmitenteEntity entityInstance) async {
    await _emitenteEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<EmitenteEntity> entityInstance) async {
    await _emitenteEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(EmitenteEntity entityInstance) async {
    await _emitenteEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$FormaPagamentoDao extends FormaPagamentoDao {
  _$FormaPagamentoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _formaPagamentoEntityInsertionAdapter = InsertionAdapter(
            database,
            'formaPagto',
            (FormaPagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                }),
        _formaPagamentoEntityUpdateAdapter = UpdateAdapter(
            database,
            'formaPagto',
            ['id'],
            (FormaPagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                }),
        _formaPagamentoEntityDeletionAdapter = DeletionAdapter(
            database,
            'formaPagto',
            ['id'],
            (FormaPagamentoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codSefaz': item.codSefaz,
                  'descricao': item.descricao
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FormaPagamentoEntity> _formaPagamentoEntityInsertionAdapter;

  final UpdateAdapter<FormaPagamentoEntity> _formaPagamentoEntityUpdateAdapter;

  final DeletionAdapter<FormaPagamentoEntity> _formaPagamentoEntityDeletionAdapter;

  @override
  Future<List<FormaPagamentoEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from formaPagto',
        mapper: (Map<String, Object?> row) => FormaPagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?));
  }

  @override
  Future<FormaPagamentoEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from formaPagto      where formaPagto.id = ?1',
        mapper: (Map<String, Object?> row) => FormaPagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [id]);
  }

  @override
  Future<FormaPagamentoEntity?> listarPorCodSefazDescricao(
    String codSefaz,
    String descricao,
  ) async {
    return _queryAdapter.query(
        'select *       from formaPagto      where formaPagto.codSefaz = ?1        and formaPagto.descricao = ?2',
        mapper: (Map<String, Object?> row) => FormaPagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [codSefaz, descricao]);
  }

  @override
  Future<FormaPagamentoEntity?> listarPorDescricao(String descricao) async {
    return _queryAdapter.query('select *       from formaPagto      where formaPagto.descricao = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => FormaPagamentoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codSefaz: row['codSefaz'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [descricao]);
  }

  @override
  Future<void> insertData(FormaPagamentoEntity entityInstance) async {
    await _formaPagamentoEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<FormaPagamentoEntity> entityInstance) async {
    await _formaPagamentoEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(FormaPagamentoEntity entityInstance) async {
    await _formaPagamentoEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<FormaPagamentoEntity> entityInstance) async {
    await _formaPagamentoEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(FormaPagamentoEntity entityInstance) async {
    await _formaPagamentoEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$InutilizacaoDao extends InutilizacaoDao {
  _$InutilizacaoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _inutilizacaoEntityInsertionAdapter = InsertionAdapter(
            database,
            'inutilizacao',
            (InutilizacaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'tpAmb': item.tpAmb,
                  'serie': item.serie,
                  'numeroInicial': item.numeroInicial,
                  'numeroFinal': item.numeroFinal,
                  'justificativa': item.justificativa,
                  'dhInutilizacao': item.dhInutilizacao,
                  'protocoloInutilizacao': item.protocoloInutilizacao
                }),
        _inutilizacaoEntityUpdateAdapter = UpdateAdapter(
            database,
            'inutilizacao',
            ['id'],
            (InutilizacaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'tpAmb': item.tpAmb,
                  'serie': item.serie,
                  'numeroInicial': item.numeroInicial,
                  'numeroFinal': item.numeroFinal,
                  'justificativa': item.justificativa,
                  'dhInutilizacao': item.dhInutilizacao,
                  'protocoloInutilizacao': item.protocoloInutilizacao
                }),
        _inutilizacaoEntityDeletionAdapter = DeletionAdapter(
            database,
            'inutilizacao',
            ['id'],
            (InutilizacaoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'tpAmb': item.tpAmb,
                  'serie': item.serie,
                  'numeroInicial': item.numeroInicial,
                  'numeroFinal': item.numeroFinal,
                  'justificativa': item.justificativa,
                  'dhInutilizacao': item.dhInutilizacao,
                  'protocoloInutilizacao': item.protocoloInutilizacao
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<InutilizacaoEntity> _inutilizacaoEntityInsertionAdapter;

  final UpdateAdapter<InutilizacaoEntity> _inutilizacaoEntityUpdateAdapter;

  final DeletionAdapter<InutilizacaoEntity> _inutilizacaoEntityDeletionAdapter;

  @override
  Future<List<InutilizacaoEntity>?> listar(int tpAmb) async {
    return _queryAdapter.queryList('select *       from inutilizacao      where inutilizacao.tpAmb = ?1',
        mapper: (Map<String, Object?> row) => InutilizacaoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            tpAmb: row['tpAmb'] as int?,
            serie: row['serie'] as int?,
            numeroInicial: row['numeroInicial'] as int?,
            numeroFinal: row['numeroFinal'] as int?,
            justificativa: row['justificativa'] as String?,
            dhInutilizacao: row['dhInutilizacao'] as String?,
            protocoloInutilizacao: row['protocoloInutilizacao'] as String?),
        arguments: [tpAmb]);
  }

  @override
  Future<void> insertData(InutilizacaoEntity entityInstance) async {
    await _inutilizacaoEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<InutilizacaoEntity> entityInstance) async {
    await _inutilizacaoEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(InutilizacaoEntity entityInstance) async {
    await _inutilizacaoEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<InutilizacaoEntity> entityInstance) async {
    await _inutilizacaoEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(InutilizacaoEntity entityInstance) async {
    await _inutilizacaoEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$ProdutoDao extends ProdutoDao {
  _$ProdutoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _produtoEntityInsertionAdapter = InsertionAdapter(
            database,
            'produto',
            (ProdutoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codigo': item.codigo,
                  'cean': item.cean,
                  'cbarra': item.cbarra,
                  'descricao': item.descricao,
                  'ncm': item.ncm,
                  'cest': item.cest,
                  'cfop': item.cfop,
                  'unidade': item.unidade,
                  'valor': item.valor,
                  'codigoAnp': item.codigoAnp,
                  'origem': item.origem,
                  'cstIcms': item.cstIcms,
                  'cstpiscofins': item.cstpiscofins,
                  'ativo': item.ativo == null ? null : (item.ativo! ? 1 : 0)
                }),
        _produtoEntityUpdateAdapter = UpdateAdapter(
            database,
            'produto',
            ['id'],
            (ProdutoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codigo': item.codigo,
                  'cean': item.cean,
                  'cbarra': item.cbarra,
                  'descricao': item.descricao,
                  'ncm': item.ncm,
                  'cest': item.cest,
                  'cfop': item.cfop,
                  'unidade': item.unidade,
                  'valor': item.valor,
                  'codigoAnp': item.codigoAnp,
                  'origem': item.origem,
                  'cstIcms': item.cstIcms,
                  'cstpiscofins': item.cstpiscofins,
                  'ativo': item.ativo == null ? null : (item.ativo! ? 1 : 0)
                }),
        _produtoEntityDeletionAdapter = DeletionAdapter(
            database,
            'produto',
            ['id'],
            (ProdutoEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'codigo': item.codigo,
                  'cean': item.cean,
                  'cbarra': item.cbarra,
                  'descricao': item.descricao,
                  'ncm': item.ncm,
                  'cest': item.cest,
                  'cfop': item.cfop,
                  'unidade': item.unidade,
                  'valor': item.valor,
                  'codigoAnp': item.codigoAnp,
                  'origem': item.origem,
                  'cstIcms': item.cstIcms,
                  'cstpiscofins': item.cstpiscofins,
                  'ativo': item.ativo == null ? null : (item.ativo! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProdutoEntity> _produtoEntityInsertionAdapter;

  final UpdateAdapter<ProdutoEntity> _produtoEntityUpdateAdapter;

  final DeletionAdapter<ProdutoEntity> _produtoEntityDeletionAdapter;

  @override
  Future<List<ProdutoEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from produto',
        mapper: (Map<String, Object?> row) => ProdutoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codigo: row['codigo'] as String?,
            cean: row['cean'] as String?,
            cbarra: row['cbarra'] as String?,
            descricao: row['descricao'] as String?,
            ncm: row['ncm'] as String?,
            cest: row['cest'] as String?,
            cfop: row['cfop'] as int?,
            unidade: row['unidade'] as String?,
            valor: row['valor'] as double?,
            codigoAnp: row['codigoAnp'] as String?,
            origem: row['origem'] as String?,
            cstIcms: row['cstIcms'] as String?,
            cstpiscofins: row['cstpiscofins'] as String?,
            ativo: row['ativo'] == null ? null : (row['ativo'] as int) != 0));
  }

  @override
  Future<ProdutoEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from produto      where produto.id = ?1',
        mapper: (Map<String, Object?> row) => ProdutoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codigo: row['codigo'] as String?,
            cean: row['cean'] as String?,
            cbarra: row['cbarra'] as String?,
            descricao: row['descricao'] as String?,
            ncm: row['ncm'] as String?,
            cest: row['cest'] as String?,
            cfop: row['cfop'] as int?,
            unidade: row['unidade'] as String?,
            valor: row['valor'] as double?,
            codigoAnp: row['codigoAnp'] as String?,
            origem: row['origem'] as String?,
            cstIcms: row['cstIcms'] as String?,
            cstpiscofins: row['cstpiscofins'] as String?,
            ativo: row['ativo'] == null ? null : (row['ativo'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<ProdutoEntity?> listarPorCodigo(int codigo) async {
    return _queryAdapter.query('select *       from produto      where produto.codigo = ?1',
        mapper: (Map<String, Object?> row) => ProdutoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codigo: row['codigo'] as String?,
            cean: row['cean'] as String?,
            cbarra: row['cbarra'] as String?,
            descricao: row['descricao'] as String?,
            ncm: row['ncm'] as String?,
            cest: row['cest'] as String?,
            cfop: row['cfop'] as int?,
            unidade: row['unidade'] as String?,
            valor: row['valor'] as double?,
            codigoAnp: row['codigoAnp'] as String?,
            origem: row['origem'] as String?,
            cstIcms: row['cstIcms'] as String?,
            cstpiscofins: row['cstpiscofins'] as String?,
            ativo: row['ativo'] == null ? null : (row['ativo'] as int) != 0),
        arguments: [codigo]);
  }

  @override
  Future<ProdutoEntity?> listarPorDescricao(String descricao) async {
    return _queryAdapter.query('select *       from produto      where produto.descricao = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => ProdutoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codigo: row['codigo'] as String?,
            cean: row['cean'] as String?,
            cbarra: row['cbarra'] as String?,
            descricao: row['descricao'] as String?,
            ncm: row['ncm'] as String?,
            cest: row['cest'] as String?,
            cfop: row['cfop'] as int?,
            unidade: row['unidade'] as String?,
            valor: row['valor'] as double?,
            codigoAnp: row['codigoAnp'] as String?,
            origem: row['origem'] as String?,
            cstIcms: row['cstIcms'] as String?,
            cstpiscofins: row['cstpiscofins'] as String?,
            ativo: row['ativo'] == null ? null : (row['ativo'] as int) != 0),
        arguments: [descricao]);
  }

  @override
  Future<ProdutoEntity?> listarPorEan(String cean) async {
    return _queryAdapter.query('select *       from produto      where produto.cean = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => ProdutoEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            codigo: row['codigo'] as String?,
            cean: row['cean'] as String?,
            cbarra: row['cbarra'] as String?,
            descricao: row['descricao'] as String?,
            ncm: row['ncm'] as String?,
            cest: row['cest'] as String?,
            cfop: row['cfop'] as int?,
            unidade: row['unidade'] as String?,
            valor: row['valor'] as double?,
            codigoAnp: row['codigoAnp'] as String?,
            origem: row['origem'] as String?,
            cstIcms: row['cstIcms'] as String?,
            cstpiscofins: row['cstpiscofins'] as String?,
            ativo: row['ativo'] == null ? null : (row['ativo'] as int) != 0),
        arguments: [cean]);
  }

  @override
  Future<void> insertData(ProdutoEntity entityInstance) async {
    await _produtoEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<ProdutoEntity> entityInstance) async {
    await _produtoEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(ProdutoEntity entityInstance) async {
    await _produtoEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<ProdutoEntity> entityInstance) async {
    await _produtoEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(ProdutoEntity entityInstance) async {
    await _produtoEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$UfDao extends UfDao {
  _$UfDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _ufEntityInsertionAdapter = InsertionAdapter(
            database,
            'uf',
            (UfEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'codigoIbge': item.codigoIbge,
                  'sigla': item.sigla
                }),
        _ufEntityUpdateAdapter = UpdateAdapter(
            database,
            'uf',
            ['id'],
            (UfEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'codigoIbge': item.codigoIbge,
                  'sigla': item.sigla
                }),
        _ufEntityDeletionAdapter = DeletionAdapter(
            database,
            'uf',
            ['id'],
            (UfEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'codigoIbge': item.codigoIbge,
                  'sigla': item.sigla
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UfEntity> _ufEntityInsertionAdapter;

  final UpdateAdapter<UfEntity> _ufEntityUpdateAdapter;

  final DeletionAdapter<UfEntity> _ufEntityDeletionAdapter;

  @override
  Future<List<UfEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from uf',
        mapper: (Map<String, Object?> row) => UfEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            codigoIbge: row['codigoIbge'] as int?,
            sigla: row['sigla'] as String?));
  }

  @override
  Future<UfEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from uf      where uf.id = ?1',
        mapper: (Map<String, Object?> row) => UfEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            codigoIbge: row['codigoIbge'] as int?,
            sigla: row['sigla'] as String?),
        arguments: [id]);
  }

  @override
  Future<UfEntity?> listarPorSigla(String sigla) async {
    return _queryAdapter.query('select *       from uf      where uf.sigla = ?1',
        mapper: (Map<String, Object?> row) => UfEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            codigoIbge: row['codigoIbge'] as int?,
            sigla: row['sigla'] as String?),
        arguments: [sigla]);
  }

  @override
  Future<void> insertData(UfEntity entityInstance) async {
    await _ufEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<UfEntity> entityInstance) async {
    await _ufEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(UfEntity entityInstance) async {
    await _ufEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<UfEntity> entityInstance) async {
    await _ufEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(UfEntity entityInstance) async {
    await _ufEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$UnidadeMedidaDao extends UnidadeMedidaDao {
  _$UnidadeMedidaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _unidadeMedidaEntityInsertionAdapter = InsertionAdapter(
            database,
            'unidadeMedida',
            (UnidadeMedidaEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'sigla': item.sigla,
                  'descricao': item.descricao
                }),
        _unidadeMedidaEntityUpdateAdapter = UpdateAdapter(
            database,
            'unidadeMedida',
            ['id'],
            (UnidadeMedidaEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'sigla': item.sigla,
                  'descricao': item.descricao
                }),
        _unidadeMedidaEntityDeletionAdapter = DeletionAdapter(
            database,
            'unidadeMedida',
            ['id'],
            (UnidadeMedidaEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'sigla': item.sigla,
                  'descricao': item.descricao
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UnidadeMedidaEntity> _unidadeMedidaEntityInsertionAdapter;

  final UpdateAdapter<UnidadeMedidaEntity> _unidadeMedidaEntityUpdateAdapter;

  final DeletionAdapter<UnidadeMedidaEntity> _unidadeMedidaEntityDeletionAdapter;

  @override
  Future<List<UnidadeMedidaEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from unidadeMedida',
        mapper: (Map<String, Object?> row) => UnidadeMedidaEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            sigla: row['sigla'] as String?,
            descricao: row['descricao'] as String?));
  }

  @override
  Future<UnidadeMedidaEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from unidadeMedida      where unidadeMedida.id = ?1',
        mapper: (Map<String, Object?> row) => UnidadeMedidaEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            sigla: row['sigla'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [id]);
  }

  @override
  Future<UnidadeMedidaEntity?> listarPorSiglaDescricao(
    String sigla,
    String descricao,
  ) async {
    return _queryAdapter.query(
        'select *       from unidadeMedida      where unidadeMedida.sigla = ?1        and unidadeMedida.descricao = ?2',
        mapper: (Map<String, Object?> row) => UnidadeMedidaEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            sigla: row['sigla'] as String?,
            descricao: row['descricao'] as String?),
        arguments: [sigla, descricao]);
  }

  @override
  Future<void> insertData(UnidadeMedidaEntity entityInstance) async {
    await _unidadeMedidaEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<UnidadeMedidaEntity> entityInstance) async {
    await _unidadeMedidaEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(UnidadeMedidaEntity entityInstance) async {
    await _unidadeMedidaEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<UnidadeMedidaEntity> entityInstance) async {
    await _unidadeMedidaEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(UnidadeMedidaEntity entityInstance) async {
    await _unidadeMedidaEntityDeletionAdapter.delete(entityInstance);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuarioEntityInsertionAdapter = InsertionAdapter(
            database,
            'usuario',
            (UsuarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'login': item.login,
                  'senha': item.senha
                }),
        _usuarioEntityUpdateAdapter = UpdateAdapter(
            database,
            'usuario',
            ['id'],
            (UsuarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'login': item.login,
                  'senha': item.senha
                }),
        _usuarioEntityDeletionAdapter = DeletionAdapter(
            database,
            'usuario',
            ['id'],
            (UsuarioEntity item) => <String, Object?>{
                  'id': item.id,
                  'emitenteId': item.emitenteId,
                  'nome': item.nome,
                  'login': item.login,
                  'senha': item.senha
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UsuarioEntity> _usuarioEntityInsertionAdapter;

  final UpdateAdapter<UsuarioEntity> _usuarioEntityUpdateAdapter;

  final DeletionAdapter<UsuarioEntity> _usuarioEntityDeletionAdapter;

  @override
  Future<List<UsuarioEntity>?> listar() async {
    return _queryAdapter.queryList('select *       from usuario',
        mapper: (Map<String, Object?> row) => UsuarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            login: row['login'] as String?,
            senha: row['senha'] as String?));
  }

  @override
  Future<UsuarioEntity?> listarPorId(int id) async {
    return _queryAdapter.query('select *       from usuario      where usuario.id = ?1',
        mapper: (Map<String, Object?> row) => UsuarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            login: row['login'] as String?,
            senha: row['senha'] as String?),
        arguments: [id]);
  }

  @override
  Future<UsuarioEntity?> listarPorNome(String nome) async {
    return _queryAdapter.query('select *       from usuario      where usuario.nome = \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => UsuarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            login: row['login'] as String?,
            senha: row['senha'] as String?),
        arguments: [nome]);
  }

  @override
  Future<UsuarioEntity?> listarPorLogin(String login) async {
    return _queryAdapter.query('select *       from usuario      where usuario.login = ?1',
        mapper: (Map<String, Object?> row) => UsuarioEntity(
            id: row['id'] as int?,
            emitenteId: row['emitenteId'] as int?,
            nome: row['nome'] as String?,
            login: row['login'] as String?,
            senha: row['senha'] as String?),
        arguments: [login]);
  }

  @override
  Future<void> insertData(UsuarioEntity entityInstance) async {
    await _usuarioEntityInsertionAdapter.insert(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertListData(List<UsuarioEntity> entityInstance) async {
    await _usuarioEntityInsertionAdapter.insertList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(UsuarioEntity entityInstance) async {
    await _usuarioEntityUpdateAdapter.update(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateListData(List<UsuarioEntity> entityInstance) async {
    await _usuarioEntityUpdateAdapter.updateList(entityInstance, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(UsuarioEntity entityInstance) async {
    await _usuarioEntityDeletionAdapter.delete(entityInstance);
  }
}
