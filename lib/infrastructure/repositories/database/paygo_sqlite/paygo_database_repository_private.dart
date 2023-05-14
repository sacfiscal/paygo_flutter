part of 'paygo_database_repository.dart';

abstract class IBandeiraCartaoRepository {
  Future<List<BandeiraCartaoEntity>?> listar();
  Future<BandeiraCartaoEntity?> listarPorId(int id);
  Future<BandeiraCartaoEntity?> listarPorCodSefaz(String codSefaz);
  Future<BandeiraCartaoEntity?> listarPorDescricao(String descricao);
  Future<void> insert(BandeiraCartaoEntity bandeiraCartao);
  Future<void> update(BandeiraCartaoEntity bandeiraCartao);
  Future<void> delete(BandeiraCartaoEntity bandeiraCartao);
}

abstract class IConfiguracoesRepository {
  Future<List<ConfiguracoesEntity>?> listar();
  Future<ConfiguracoesEntity?> listarPorId(int id);
  Future<void> insert(ConfiguracoesEntity bandeiraCartao);
  Future<void> update(ConfiguracoesEntity bandeiraCartao);
  Future<void> delete(ConfiguracoesEntity bandeiraCartao);
}

abstract class IDestinatarioRepository {
  Future<List<DestinatarioEntity>?> listar();
  Future<DestinatarioEntity?> listarPorId(int id);
  Future<DestinatarioEntity?> listarPorCnpjCpf(String cnpjCpf);
  Future<DestinatarioEntity?> listarPorRazaoSocial(String razaoSocial);
  Future<void> insert(DestinatarioEntity bandeiraCartao);
  Future<void> update(DestinatarioEntity bandeiraCartao);
  Future<void> delete(DestinatarioEntity bandeiraCartao);
}

abstract class IDocumentoNfceRepository {
  Future<List<DocumentoNfceEntity>?> listar(int tpAmb);
  Future<DocumentoNfceEntity?> listarPorId(int tpAmb, int id);
  Future<DocumentoNfceEntity?> listarPorSerieNf(int tpAmb, int serie, int nNF);
  Future<void> insert(DocumentoNfceEntity bandeiraCartao);
  Future<void> update(DocumentoNfceEntity bandeiraCartao);
  Future<void> delete(DocumentoNfceEntity bandeiraCartao);
}

abstract class IDocumentoNfceItemRepository {
  Future<List<DocumentoNfceItemEntity>?> listar();
  Future<DocumentoNfceItemEntity?> listarPorId(int id);
  Future<List<DocumentoNfceItemEntity>?> listarPorIdDocumento(int documentoId);
  Future<void> insert(DocumentoNfceItemEntity bandeiraCartao);
  Future<void> update(DocumentoNfceItemEntity bandeiraCartao);
  Future<void> delete(DocumentoNfceItemEntity bandeiraCartao);
}

abstract class IDocumentoNfcePagamentoRepository {
  Future<List<DocumentoNfcePagamentoEntity>?> listar();
  Future<DocumentoNfcePagamentoEntity?> listarPorId(int id);
  Future<DocumentoNfcePagamentoEntity?> listarPorIdDocumento(int documentoId);
  Future<void> insert(DocumentoNfcePagamentoEntity bandeiraCartao);
  Future<void> update(DocumentoNfcePagamentoEntity bandeiraCartao);
  Future<void> delete(DocumentoNfcePagamentoEntity bandeiraCartao);
}

abstract class IEmitenteRepository {
  Future<List<EmitenteEntity>?> listar();
  Future<EmitenteEntity?> listarPorId(int id);
  Future<EmitenteEntity?> listarPorCpfCnpj(String cnpjCpf);
  Future<EmitenteEntity?> listarPorRazaoSocial(String razaoSocial);
  Future<void> insert(EmitenteEntity bandeiraCartao);
  Future<void> update(EmitenteEntity bandeiraCartao);
  Future<void> delete(EmitenteEntity bandeiraCartao);
}

abstract class IFormaPagamentoRepository {
  Future<List<FormaPagamentoEntity>?> listar();
  Future<FormaPagamentoEntity?> listarPorId(int id);
  Future<FormaPagamentoEntity?> listarPorCodSefazDescricao(String codSefaz, String descricao);
  Future<FormaPagamentoEntity?> listarPorDescricao(String descricao);
  Future<void> insert(FormaPagamentoEntity bandeiraCartao);
  Future<void> update(FormaPagamentoEntity bandeiraCartao);
  Future<void> delete(FormaPagamentoEntity bandeiraCartao);
}

abstract class IInutilizacaoRepository {
  Future<List<InutilizacaoEntity>?> listar(int tpAmb);
  Future<void> insert(InutilizacaoEntity bandeiraCartao);
  Future<void> update(InutilizacaoEntity bandeiraCartao);
  Future<void> delete(InutilizacaoEntity bandeiraCartao);
}

abstract class IProdutoRepository {
  Future<List<ProdutoEntity>?> listar();
  Future<ProdutoEntity?> listarPorId(int id);
  Future<ProdutoEntity?> listarPorCodigo(int codigo);
  Future<ProdutoEntity?> listarPorDescricao(String descricao);
  Future<ProdutoEntity?> listarPorEan(String cean);
  Future<void> insert(ProdutoEntity bandeiraCartao);
  Future<void> update(ProdutoEntity bandeiraCartao);
  Future<void> delete(ProdutoEntity bandeiraCartao);
}

abstract class IUfRepository {
  Future<List<UfEntity>?> listar();
  Future<UfEntity?> listarPorId(int id);
  Future<UfEntity?> listarPorSigla(String sigla);
  Future<void> insert(UfEntity bandeiraCartao);
  Future<void> update(UfEntity bandeiraCartao);
  Future<void> delete(UfEntity bandeiraCartao);
}

abstract class IUnidadeMedidaRepository {
  Future<List<UnidadeMedidaEntity>?> listar();
  Future<UnidadeMedidaEntity?> listarPorId(int id);
  Future<UnidadeMedidaEntity?> listarPorSiglaDescricao(String unidade, String descricao);
  Future<void> insert(UnidadeMedidaEntity bandeiraCartao);
  Future<void> update(UnidadeMedidaEntity bandeiraCartao);
  Future<void> delete(UnidadeMedidaEntity bandeiraCartao);
}

abstract class IUsuarioRepository {
  Future<List<UsuarioEntity>?> listar();
  Future<UsuarioEntity?> listarPorId(int id);
  Future<UsuarioEntity?> listarPorNome(String nome);
  Future<UsuarioEntity?> listarPorLogin(String login);
  Future<void> insert(UsuarioEntity bandeiraCartao);
  Future<void> update(UsuarioEntity bandeiraCartao);
  Future<void> delete(UsuarioEntity bandeiraCartao);
}

class _BandeiraCartaoRepository implements IBandeiraCartaoRepository {
  @override
  Future<List<BandeiraCartaoEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().bandeiraCartaoDao.listar();
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().bandeiraCartaoDao.listarPorId(id);
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorCodSefaz(String codSefaz) async {
    return await Get.find<PayGoSqliteService>().bandeiraCartaoDao.listarPorCodSefaz(codSefaz);
  }

  @override
  Future<BandeiraCartaoEntity?> listarPorDescricao(String descricao) async {
    return await Get.find<PayGoSqliteService>().bandeiraCartaoDao.listarPorDescricao(descricao);
  }

  @override
  Future<void> insert(BandeiraCartaoEntity bandeiraCartao) async {
    await Get.find<PayGoSqliteService>().bandeiraCartaoDao.insertData(bandeiraCartao);
  }

  @override
  Future<void> update(BandeiraCartaoEntity bandeiraCartao) async {
    await Get.find<PayGoSqliteService>().bandeiraCartaoDao.updateData(bandeiraCartao);
  }

  @override
  Future<void> delete(BandeiraCartaoEntity bandeiraCartao) async {
    await Get.find<PayGoSqliteService>().bandeiraCartaoDao.deleteData(bandeiraCartao);
  }
}

class _ConfiguracoesRepository implements IConfiguracoesRepository {
  @override
  Future<List<ConfiguracoesEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().configuracoesDao.listar();
  }

  @override
  Future<ConfiguracoesEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().configuracoesDao.listarPorId(id);
  }

  @override
  Future<void> insert(ConfiguracoesEntity configuracoes) async {
    await Get.find<PayGoSqliteService>().configuracoesDao.insertData(configuracoes);
  }

  @override
  Future<void> update(ConfiguracoesEntity configuracoes) async {
    await Get.find<PayGoSqliteService>().configuracoesDao.updateData(configuracoes);
  }

  @override
  Future<void> delete(ConfiguracoesEntity configuracoes) async {
    await Get.find<PayGoSqliteService>().configuracoesDao.deleteData(configuracoes);
  }
}

class _DestinatarioRepository implements IDestinatarioRepository {
  @override
  Future<List<DestinatarioEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().destinatarioDao.listar();
  }

  @override
  Future<DestinatarioEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().destinatarioDao.listarPorId(id);
  }

  @override
  Future<DestinatarioEntity?> listarPorCnpjCpf(String cnpjCpf) async {
    return await Get.find<PayGoSqliteService>().destinatarioDao.listarPorCnpjCpf(cnpjCpf);
  }

  @override
  Future<DestinatarioEntity?> listarPorRazaoSocial(String razaoSocial) async {
    return await Get.find<PayGoSqliteService>().destinatarioDao.listarPorRazaoSocial(razaoSocial);
  }

  @override
  Future<void> insert(DestinatarioEntity destinatario) async {
    await Get.find<PayGoSqliteService>().destinatarioDao.insertData(destinatario);
  }

  @override
  Future<void> update(DestinatarioEntity destinatario) async {
    await Get.find<PayGoSqliteService>().destinatarioDao.updateData(destinatario);
  }

  @override
  Future<void> delete(DestinatarioEntity destinatario) async {
    await Get.find<PayGoSqliteService>().destinatarioDao.deleteData(destinatario);
  }
}

class _DocumentoNfceRepository implements IDocumentoNfceRepository {
  @override
  Future<List<DocumentoNfceEntity>?> listar(int tpAmb) async {
    return await Get.find<PayGoSqliteService>().documentoNfceDao.listar(tpAmb);
  }

  @override
  Future<DocumentoNfceEntity?> listarPorId(int tpAmb, int id) async {
    return await Get.find<PayGoSqliteService>().documentoNfceDao.listarPorId(tpAmb, id);
  }

  @override
  Future<DocumentoNfceEntity?> listarPorSerieNf(int tpAmb, int serie, int nNF) async {
    return await Get.find<PayGoSqliteService>().documentoNfceDao.listarPorSerieNf(tpAmb, serie, nNF);
  }

  @override
  Future<void> insert(DocumentoNfceEntity documentoNfce) async {
    await Get.find<PayGoSqliteService>().documentoNfceDao.insertData(documentoNfce);
  }

  @override
  Future<void> update(DocumentoNfceEntity documentoNfce) async {
    await Get.find<PayGoSqliteService>().documentoNfceDao.updateData(documentoNfce);
  }

  @override
  Future<void> delete(DocumentoNfceEntity documentoNfce) async {
    await Get.find<PayGoSqliteService>().documentoNfceDao.deleteData(documentoNfce);
  }
}

class _DocumentoNfceItemRepository implements IDocumentoNfceItemRepository {
  @override
  Future<List<DocumentoNfceItemEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().documentoNfceItemDao.listar();
  }

  @override
  Future<DocumentoNfceItemEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().documentoNfceItemDao.listarPorId(id);
  }

  @override
  Future<List<DocumentoNfceItemEntity>?> listarPorIdDocumento(int documentoId) async {
    return await Get.find<PayGoSqliteService>().documentoNfceItemDao.listarPorIdDocumento(documentoId);
  }

  @override
  Future<void> insert(DocumentoNfceItemEntity documentoNfceItem) async {
    await Get.find<PayGoSqliteService>().documentoNfceItemDao.insertData(documentoNfceItem);
  }

  @override
  Future<void> update(DocumentoNfceItemEntity documentoNfceItem) async {
    await Get.find<PayGoSqliteService>().documentoNfceItemDao.updateData(documentoNfceItem);
  }

  @override
  Future<void> delete(DocumentoNfceItemEntity documentoNfceItem) async {
    await Get.find<PayGoSqliteService>().documentoNfceItemDao.deleteData(documentoNfceItem);
  }
}

class _DocumentoNfcePagamentoRepository implements IDocumentoNfcePagamentoRepository {
  @override
  Future<List<DocumentoNfcePagamentoEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.listar();
  }

  @override
  Future<DocumentoNfcePagamentoEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.listarPorId(id);
  }

  @override
  Future<DocumentoNfcePagamentoEntity?> listarPorIdDocumento(int documentoId) async {
    return await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.listarPorIdDocumento(documentoId);
  }

  @override
  Future<void> insert(DocumentoNfcePagamentoEntity documentoNfcePagamento) async {
    await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.insertData(documentoNfcePagamento);
  }

  @override
  Future<void> update(DocumentoNfcePagamentoEntity documentoNfcePagamento) async {
    await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.updateData(documentoNfcePagamento);
  }

  @override
  Future<void> delete(DocumentoNfcePagamentoEntity documentoNfcePagamento) async {
    await Get.find<PayGoSqliteService>().documentoNfcePagamentoDao.deleteData(documentoNfcePagamento);
  }
}

class _EmitenteRepository implements IEmitenteRepository {
  @override
  Future<List<EmitenteEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().emitenteDao.listar();
  }

  @override
  Future<EmitenteEntity?> listarPorId(int id) async {
    var retorno = await Get.find<PayGoSqliteService>().emitenteDao.listarPorId(id);
    return retorno;
  }

  @override
  Future<EmitenteEntity?> listarPorCpfCnpj(String cnpjCpf) async {
    return await Get.find<PayGoSqliteService>().emitenteDao.listarPorCpfCnpj(cnpjCpf);
  }

  @override
  Future<EmitenteEntity?> listarPorRazaoSocial(String razaoSocial) async {
    return await Get.find<PayGoSqliteService>().emitenteDao.listarPorRazaoSocial(razaoSocial);
  }

  @override
  Future<void> insert(EmitenteEntity emitente) async {
    await Get.find<PayGoSqliteService>().emitenteDao.insertData(emitente);
  }

  @override
  Future<void> update(EmitenteEntity emitente) async {
    await Get.find<PayGoSqliteService>().emitenteDao.updateData(emitente);
  }

  @override
  Future<void> delete(EmitenteEntity emitente) async {
    await Get.find<PayGoSqliteService>().emitenteDao.deleteData(emitente);
  }
}

class _FormaPagamentoRepository implements IFormaPagamentoRepository {
  @override
  Future<List<FormaPagamentoEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().formaPagamentoDao.listar();
  }

  @override
  Future<FormaPagamentoEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().formaPagamentoDao.listarPorId(id);
  }

  @override
  Future<FormaPagamentoEntity?> listarPorCodSefazDescricao(String codSefaz, String descricao) async {
    return await Get.find<PayGoSqliteService>().formaPagamentoDao.listarPorCodSefazDescricao(codSefaz, descricao);
  }

  @override
  Future<FormaPagamentoEntity?> listarPorDescricao(String descricao) async {
    return await Get.find<PayGoSqliteService>().formaPagamentoDao.listarPorDescricao(descricao);
  }

  @override
  Future<void> insert(FormaPagamentoEntity formaPagamento) async {
    await Get.find<PayGoSqliteService>().formaPagamentoDao.insertData(formaPagamento);
  }

  @override
  Future<void> update(FormaPagamentoEntity formaPagamento) async {
    await Get.find<PayGoSqliteService>().formaPagamentoDao.updateData(formaPagamento);
  }

  @override
  Future<void> delete(FormaPagamentoEntity formaPagamento) async {
    await Get.find<PayGoSqliteService>().formaPagamentoDao.deleteData(formaPagamento);
  }
}

class _InutilizacaoRepository implements IInutilizacaoRepository {
  @override
  Future<List<InutilizacaoEntity>?> listar(int tpAmb) async {
    return await Get.find<PayGoSqliteService>().inutilizacaoDao.listar(tpAmb);
  }

  @override
  Future<void> insert(InutilizacaoEntity inutilizacao) async {
    await Get.find<PayGoSqliteService>().inutilizacaoDao.insertData(inutilizacao);
  }

  @override
  Future<void> update(InutilizacaoEntity inutilizacao) async {
    await Get.find<PayGoSqliteService>().inutilizacaoDao.updateData(inutilizacao);
  }

  @override
  Future<void> delete(InutilizacaoEntity inutilizacao) async {
    await Get.find<PayGoSqliteService>().inutilizacaoDao.deleteData(inutilizacao);
  }
}

class _ProdutoRepository implements IProdutoRepository {
  @override
  Future<List<ProdutoEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().produtoDao.listar();
  }

  @override
  Future<ProdutoEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().produtoDao.listarPorId(id);
  }

  @override
  Future<ProdutoEntity?> listarPorCodigo(int codigo) async {
    return await Get.find<PayGoSqliteService>().produtoDao.listarPorCodigo(codigo);
  }

  @override
  Future<ProdutoEntity?> listarPorDescricao(String descricao) async {
    return await Get.find<PayGoSqliteService>().produtoDao.listarPorDescricao(descricao);
  }

  @override
  Future<ProdutoEntity?> listarPorEan(String cean) async {
    return await Get.find<PayGoSqliteService>().produtoDao.listarPorEan(cean);
  }

  @override
  Future<void> insert(ProdutoEntity produto) async {
    await Get.find<PayGoSqliteService>().produtoDao.insertData(produto);
  }

  @override
  Future<void> update(ProdutoEntity produto) async {
    await Get.find<PayGoSqliteService>().produtoDao.updateData(produto);
  }

  @override
  Future<void> delete(ProdutoEntity produto) async {
    await Get.find<PayGoSqliteService>().produtoDao.deleteData(produto);
  }
}

class _UfRepository implements IUfRepository {
  @override
  Future<List<UfEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().ufDao.listar();
  }

  @override
  Future<UfEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().ufDao.listarPorId(id);
  }

  @override
  Future<UfEntity?> listarPorSigla(String sigla) async {
    return await Get.find<PayGoSqliteService>().ufDao.listarPorSigla(sigla);
  }

  @override
  Future<void> insert(UfEntity uf) async {
    await Get.find<PayGoSqliteService>().ufDao.insertData(uf);
  }

  @override
  Future<void> update(UfEntity uf) async {
    await Get.find<PayGoSqliteService>().ufDao.updateData(uf);
  }

  @override
  Future<void> delete(UfEntity uf) async {
    await Get.find<PayGoSqliteService>().ufDao.deleteData(uf);
  }
}

class _UnidadeMedidaRepository implements IUnidadeMedidaRepository {
  @override
  Future<List<UnidadeMedidaEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().unidadeMedidaDao.listar();
  }

  @override
  Future<UnidadeMedidaEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().unidadeMedidaDao.listarPorId(id);
  }

  @override
  Future<UnidadeMedidaEntity?> listarPorSiglaDescricao(String unidade, String descricao) async {
    return await Get.find<PayGoSqliteService>().unidadeMedidaDao.listarPorSiglaDescricao(unidade, descricao);
  }

  @override
  Future<void> insert(UnidadeMedidaEntity unidadeMedida) async {
    await Get.find<PayGoSqliteService>().unidadeMedidaDao.insertData(unidadeMedida);
  }

  @override
  Future<void> update(UnidadeMedidaEntity unidadeMedida) async {
    await Get.find<PayGoSqliteService>().unidadeMedidaDao.updateData(unidadeMedida);
  }

  @override
  Future<void> delete(UnidadeMedidaEntity unidadeMedida) async {
    await Get.find<PayGoSqliteService>().unidadeMedidaDao.deleteData(unidadeMedida);
  }
}

class _UsuarioRepository implements IUsuarioRepository {
  @override
  Future<List<UsuarioEntity>?> listar() async {
    return await Get.find<PayGoSqliteService>().usuarioDao.listar();
  }

  @override
  Future<UsuarioEntity?> listarPorId(int id) async {
    return await Get.find<PayGoSqliteService>().usuarioDao.listarPorId(id);
  }

  @override
  Future<UsuarioEntity?> listarPorNome(String nome) async {
    return await Get.find<PayGoSqliteService>().usuarioDao.listarPorNome(nome);
  }

  @override
  Future<UsuarioEntity?> listarPorLogin(String login) async {
    return await Get.find<PayGoSqliteService>().usuarioDao.listarPorLogin(login);
  }

  @override
  Future<void> insert(UsuarioEntity usuario) async {
    await Get.find<PayGoSqliteService>().usuarioDao.insertData(usuario);
  }

  @override
  Future<void> update(UsuarioEntity usuario) async {
    await Get.find<PayGoSqliteService>().usuarioDao.updateData(usuario);
  }

  @override
  Future<void> delete(UsuarioEntity usuario) async {
    await Get.find<PayGoSqliteService>().usuarioDao.deleteData(usuario);
  }
}
