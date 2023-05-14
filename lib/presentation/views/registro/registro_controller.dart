import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/bandeira_cartao_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/service/paygo_sqlite_service.dart';
import 'package:paygo_app/presentation/views/loading/loading_view.dart';

import '../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import '../../../infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import '../../../infrastructure/repositories/shared_preferences/configuracoes_repository.dart';
import '../../../infrastructure/routes/navigation_pages.dart';
import '../../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/empresa_configuracao_nfce_dto.dart';
import '../../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/empresa_dto.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/configuracoes_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/destinatario_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/emitente_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/forma_pagamento_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/produto_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/uf_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/unidade_medida_entity.dart';
import '../../../infrastructure/services/database/paygo_sqlite/entities/usuario_entity.dart';

class RegistroController extends GetxController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //14063822000126
  final _cnpjEmpresa = ''.obs;
  final _cnpjValidateString = ''.obs;

  final _isLoading = false.obs;

  GlobalKey<FormState> get formKey => _formKey;

  get cnpjEmpresa => _cnpjEmpresa.value;
  set cnpjEmpresa(value) => _cnpjEmpresa.value = value;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  Future<void> incluirUF(int? emitenteId) async {
    List<Map<String, dynamic>> lista = [];

    lista.add({'id': 01, 'sigla': 'AC', 'nome': 'Acre', 'codigoIbge': 12});
    lista.add({'id': 02, 'sigla': 'AL', 'nome': 'Alagoas', 'codigoIbge': 27});
    lista.add({'id': 03, 'sigla': 'AP', 'nome': 'Amapá', 'codigoIbge': 16});
    lista.add({'id': 04, 'sigla': 'AM', 'nome': 'Amazonas', 'codigoIbge': 13});
    lista.add({'id': 05, 'sigla': 'BA', 'nome': 'Bahia', 'codigoIbge': 29});
    lista.add({'id': 06, 'sigla': 'CE', 'nome': 'Ceará', 'codigoIbge': 23});
    lista.add({'id': 07, 'sigla': 'DF', 'nome': 'Distrito Federal', 'codigoIbge': 53});
    lista.add({'id': 08, 'sigla': 'ES', 'nome': 'Espírito Santo', 'codigoIbge': 32});
    lista.add({'id': 09, 'sigla': 'GO', 'nome': 'Goiás', 'codigoIbge': 52});
    lista.add({'id': 10, 'sigla': 'MA', 'nome': 'Maranhão', 'codigoIbge': 21});
    lista.add({'id': 11, 'sigla': 'MT', 'nome': 'Mato Grosso', 'codigoIbge': 51});
    lista.add({'id': 12, 'sigla': 'MS', 'nome': 'Mato Grosso do Sul', 'codigoIbge': 50});
    lista.add({'id': 13, 'sigla': 'MG', 'nome': 'Minas Gerais', 'codigoIbge': 31});
    lista.add({'id': 14, 'sigla': 'PA', 'nome': 'Pará', 'codigoIbge': 15});
    lista.add({'id': 15, 'sigla': 'PB', 'nome': 'Paraíba', 'codigoIbge': 25});
    lista.add({'id': 16, 'sigla': 'PR', 'nome': 'Paraná', 'codigoIbge': 41});
    lista.add({'id': 17, 'sigla': 'PE', 'nome': 'Pernambuco', 'codigoIbge': 26});
    lista.add({'id': 18, 'sigla': 'PI', 'nome': 'Piauí', 'codigoIbge': 22});
    lista.add({'id': 19, 'sigla': 'RJ', 'nome': 'Rio de Janeiro', 'codigoIbge': 33});
    lista.add({'id': 20, 'sigla': 'RN', 'nome': 'Rio Grande do Norte', 'codigoIbge': 24});
    lista.add({'id': 21, 'sigla': 'RS', 'nome': 'Rio Grande do Sul', 'codigoIbge': 43});
    lista.add({'id': 22, 'sigla': 'RO', 'nome': 'Rondônia', 'codigoIbge': 11});
    lista.add({'id': 23, 'sigla': 'RR', 'nome': 'Roraima', 'codigoIbge': 14});
    lista.add({'id': 24, 'sigla': 'SC', 'nome': 'Santa Catarina', 'codigoIbge': 42});
    lista.add({'id': 25, 'sigla': 'SP', 'nome': 'São Paulo', 'codigoIbge': 35});
    lista.add({'id': 26, 'sigla': 'SE', 'nome': 'Sergipe', 'codigoIbge': 28});
    lista.add({'id': 27, 'sigla': 'TO', 'nome': 'Tocantins', 'codigoIbge': 17});

    for (var item in lista) {
      await Get.find<PaygoDatabaseRepository>().uf.insert(
            UfEntity(
              emitenteId: emitenteId,
              sigla: item['sigla'],
              nome: item['nome'],
              codigoIbge: item['codigoIbge'],
            ),
          );
    }
  }

  Future<void> incluirFormaPagamento(int? emitenteId) async {
    List<Map<String, dynamic>> lista = [];

    lista.add({'id': 01, 'codSefaz': '01', 'descricao': 'Dinheiro'});
    lista.add({'id': 02, 'codSefaz': '02', 'descricao': 'Cheque'});
    lista.add({'id': 03, 'codSefaz': '03', 'descricao': 'Cartão de Crédito'});
    lista.add({'id': 04, 'codSefaz': '04', 'descricao': 'Cartão de Débito'});
    lista.add({'id': 05, 'codSefaz': '05', 'descricao': 'Crédito de Loja'});
    lista.add({'id': 06, 'codSefaz': '10', 'descricao': 'Vale Alimentação'});
    lista.add({'id': 07, 'codSefaz': '11', 'descricao': 'Vale Refeição'});
    lista.add({'id': 08, 'codSefaz': '12', 'descricao': 'Vale Presente'});
    lista.add({'id': 09, 'codSefaz': '13', 'descricao': 'Vale Combustível'});
    lista.add({'id': 10, 'codSefaz': '14', 'descricao': 'Duplicata Mercantil'});
    lista.add({'id': 11, 'codSefaz': '15', 'descricao': 'Boleto Bancário'});
    lista.add({'id': 12, 'codSefaz': '16', 'descricao': 'Depósito Bancário'});
    lista.add({'id': 13, 'codSefaz': '17', 'descricao': 'PIX - Pagto Instantâneo'});
    lista.add({'id': 14, 'codSefaz': '18', 'descricao': 'Transferência bancária, Carteira Digital'});
    lista.add({'id': 15, 'codSefaz': '19', 'descricao': 'Programa de fidelidade, Cashback, Crédito Virtual'});
    lista.add({'id': 16, 'codSefaz': '90', 'descricao': 'Sem Pagamento'});
    lista.add({'id': 17, 'codSefaz': '99', 'descricao': 'Outros'});

    for (var item in lista) {
      await Get.find<PaygoDatabaseRepository>().formaPagamento.insert(
            FormaPagamentoEntity(
              emitenteId: emitenteId,
              codSefaz: item['codSefaz'],
              descricao: item['descricao'],
            ),
          );
    }
  }

  Future<void> incluirbandeiraCartao(int? emitenteId) async {
    List<Map<String, dynamic>> lista = [];

    lista.add({'id': 1, 'codSefaz': '01', 'descricao': 'Visa'});
    lista.add({'id': 2, 'codSefaz': '02', 'descricao': 'Mastercard'});
    lista.add({'id': 3, 'codSefaz': '03', 'descricao': 'American Express'});
    lista.add({'id': 4, 'codSefaz': '04', 'descricao': 'Sorocred'});
    lista.add({'id': 5, 'codSefaz': '05', 'descricao': 'Diners Club'});
    lista.add({'id': 6, 'codSefaz': '06', 'descricao': 'Elo'});
    lista.add({'id': 7, 'codSefaz': '07', 'descricao': 'Hipercard'});
    lista.add({'id': 8, 'codSefaz': '08', 'descricao': 'Aura'});
    lista.add({'id': 9, 'codSefaz': '09', 'descricao': 'Cabal'});
    lista.add({'id': 10, 'codSefaz': '10', 'descricao': 'Alelo'});
    lista.add({'id': 11, 'codSefaz': '11', 'descricao': 'Banes Card'});
    lista.add({'id': 12, 'codSefaz': '12', 'descricao': 'CalCard'});
    lista.add({'id': 13, 'codSefaz': '13', 'descricao': 'Credz'});
    lista.add({'id': 14, 'codSefaz': '14', 'descricao': 'Discover'});
    lista.add({'id': 15, 'codSefaz': '15', 'descricao': 'GoodCard'});
    lista.add({'id': 16, 'codSefaz': '16', 'descricao': 'GreenCard'});
    lista.add({'id': 17, 'codSefaz': '17', 'descricao': 'Hiper'});
    lista.add({'id': 18, 'codSefaz': '18', 'descricao': 'JcB'});
    lista.add({'id': 19, 'codSefaz': '19', 'descricao': 'Mais'});
    lista.add({'id': 20, 'codSefaz': '20', 'descricao': 'MaxVan'});
    lista.add({'id': 21, 'codSefaz': '21', 'descricao': 'Policard'});
    lista.add({'id': 22, 'codSefaz': '22', 'descricao': 'RedeCompras'});
    lista.add({'id': 23, 'codSefaz': '23', 'descricao': 'Sodexo'});
    lista.add({'id': 24, 'codSefaz': '24', 'descricao': 'ValeCard'});
    lista.add({'id': 25, 'codSefaz': '25', 'descricao': 'Verocheque'});
    lista.add({'id': 26, 'codSefaz': '26', 'descricao': 'VR'});
    lista.add({'id': 27, 'codSefaz': '27', 'descricao': 'Ticket'});
    lista.add({'id': 28, 'codSefaz': '99', 'descricao': 'Outros'});

    for (var item in lista) {
      await Get.find<PaygoDatabaseRepository>().bandeiraCartao.insert(
            BandeiraCartaoEntity(
              emitenteId: emitenteId,
              codSefaz: item['codSefaz'],
              descricao: item['descricao'],
            ),
          );
    }
  }

  Future<void> incluirUnidadesMedida(int? emitenteId) async {
    List<Map<String, dynamic>> lista = [];

    lista.add({'id': 1, 'sigla': 'UN', 'descricao': 'Unidade'});
    lista.add({'id': 2, 'sigla': 'CX', 'descricao': 'Caixa'});
    lista.add({'id': 3, 'sigla': 'L', 'descricao': 'Litro'});
    lista.add({'id': 4, 'sigla': 'KG', 'descricao': 'Quilograma'});
    lista.add({'id': 5, 'sigla': 'M', 'descricao': 'Metro'});
    lista.add({'id': 6, 'sigla': 'CJ', 'descricao': 'Conjunto'});
    lista.add({'id': 7, 'sigla': 'GR', 'descricao': 'Grama'});
    lista.add({'id': 8, 'sigla': 'M2', 'descricao': 'Metro Quadrado'});
    lista.add({'id': 9, 'sigla': 'M3', 'descricao': 'Metro Cúbico'});
    lista.add({'id': 10, 'sigla': 'TON', 'descricao': 'Tonelada'});

    for (var item in lista) {
      await Get.find<PaygoDatabaseRepository>().unidadeMedida.insert(
            UnidadeMedidaEntity(
              emitenteId: emitenteId,
              sigla: item['sigla'],
              descricao: item['descricao'],
            ),
          );
    }
  }

  Future<void> incluirDestinatarioPadrao({
    int? emitenteId,
    bool pessoaJuridica = false,
  }) async {
    await Get.find<PaygoDatabaseRepository>().destinatario.insert(
          DestinatarioEntity(
            emitenteId: emitenteId,
            razaoSocial: 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL',
            nomeFantasia: 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL',
            cnpjCpf: pessoaJuridica ? '99999999999999' : '99999999999',
            ie: 'ISENTO',
            idEstrangeiro: '',
            indIeDest: '9',
            cep: '',
            logradouro: '',
            numero: '',
            complemento: '',
            bairro: '',
            codigoMunicipio: '3550308',
            municipio: 'SÃO PAULO',
            uf: 'SP',
            fone: '99999999999',
            email: 'email@provedor.com.br',
          ),
        );
  }

  Future<void> incluirProdutoPadrao(int? emitenteId) async {
    await Get.find<PaygoDatabaseRepository>().produto.insert(
          ProdutoEntity(
            emitenteId: emitenteId,
            ativo: true,
            codigo: '1',
            descricao: 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL (1)',
            unidade: 'UN',
            valor: 19.99,
            cean: 'SEM GTIN',
            cbarra: '',
            ncm: '21069090',
            cest: '1710100',
            cfop: 5102,
            codigoAnp: '0',
            origem: '0',
            cstIcms: '102',
            cstpiscofins: '49',
          ),
        );

    await Get.find<PaygoDatabaseRepository>().produto.insert(
          ProdutoEntity(
            emitenteId: emitenteId,
            ativo: true,
            codigo: '2',
            descricao: 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL (2)',
            unidade: 'UN',
            valor: 5.76,
            cean: 'SEM GTIN',
            cbarra: '',
            ncm: '21069090',
            cest: '1710100',
            cfop: 5102,
            codigoAnp: '0',
            origem: '0',
            cstIcms: '102',
            cstpiscofins: '49',
          ),
        );

    await Get.find<PaygoDatabaseRepository>().produto.insert(
          ProdutoEntity(
            emitenteId: emitenteId,
            ativo: true,
            codigo: '3',
            descricao: 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL (3)',
            unidade: 'UN',
            valor: 100.0,
            cean: 'SEM GTIN',
            cbarra: '',
            ncm: '21069090',
            cest: '1710100',
            cfop: 5102,
            codigoAnp: '0',
            origem: '0',
            cstIcms: '102',
            cstpiscofins: '49',
          ),
        );
  }

  Future<void> inicalizarTabelas(int? emitenteId) async {
    // Limpando registros

    PayGoSqliteService service = Get.find<PayGoSqliteService>();

    await service.database.delete('uf');
    await service.database.delete('formaPagto');
    await service.database.delete('bandeiraCartao');
    await service.database.delete('unidadeMedida');
    await service.database.delete('destinatario');
    await service.database.delete('produto');

    // Carregando Estados
    await incluirUF(emitenteId);

    // Carregando Formas de Pagamento padrão
    await incluirFormaPagamento(emitenteId);

    // Carregando lista de Bandeiras de cartão
    await incluirbandeiraCartao(emitenteId);

    // Carregando Unidades de Medida
    await incluirUnidadesMedida(emitenteId);

    // Carregando Destinatário Padrão
    await incluirDestinatarioPadrao(
      emitenteId: emitenteId,
      pessoaJuridica: true,
    );
    await incluirDestinatarioPadrao(
      emitenteId: emitenteId,
      pessoaJuridica: false,
    );

    // Carregando Produto Padrão
    await incluirProdutoPadrao(emitenteId);
  }

  void efetuarLogin() async {
    _cnpjValidateString.value = '';

    if (_formKey.currentState!.validate()) {
      Get.toNamed(
        NavigationRoutes.loading,
        arguments: {
          'duration': Duration(seconds: 1),
          'nextRoute': NavigationRoutes.login,
          'loadingActionMode': LoadingActionModeType.offAllNamed,
          'loadingActionFunction': (loadingTextSetter) async {
            try {
              int? emitenteId = 1;

              // Inicando a validação da empresa

              loadingTextSetter(
                'Validando o cadastro da empresa',
                true,
                true,
              );

              await Future.delayed(Duration(seconds: 1));

              // Validando o cadastro da empresa

              EmpresaDto? empresaDto = await Get.find<DocumentosEletronicosRepository>()
                  .empresa
                  .cpfCnpj
                  .consultarEmpresa(cnpjCpf: cnpjEmpresa);

              // Verificando se a empresa existe
              // Se não existir, será lançado uma exceção
              // Se existir, será retornado os dados da empresa

              EmpresaConfiguracaoNfceDto empresaConfiguracaoNfceDto = await Get.find<DocumentosEletronicosRepository>()
                  .empresa
                  .cpfCnpj
                  .nfce
                  .consultarConfiguracao(cnpjCpf: cnpjEmpresa);

              // Cadastrando o emitente

              EmitenteEntity? emitenteEntity = await Get.find<PaygoDatabaseRepository>().emitente.listarPorId(1);

              if (emitenteEntity == null) {
                await Get.find<PaygoDatabaseRepository>().emitente.insert(
                      EmitenteEntity(
                        razaoSocial: empresaDto.nomeRazaoSocial,
                        nomeFantasia: empresaDto.nomeFantasia,
                        cnpjCpf: empresaDto.cpfCnpj,
                        ie: empresaDto.inscricaoEstadual,
                        crt: empresaConfiguracaoNfceDto.crt.toString(),
                        csc: empresaConfiguracaoNfceDto.sefaz.csc,
                        idCsc: empresaConfiguracaoNfceDto.sefaz.idCsc.toString(),
                        cep: empresaDto.endereco.cep,
                        logradouro: empresaDto.endereco.logradouro,
                        numero: empresaDto.endereco.numero,
                        complemento: '',
                        bairro: empresaDto.endereco.bairro,
                        codigoMunicipio: empresaDto.endereco.codigoMunicipio,
                        municipio: empresaDto.endereco.cidade,
                        uf: empresaDto.endereco.uf,
                        fone: empresaDto.fone,
                      ),
                    );
              } else {
                emitenteEntity = EmitenteEntity(
                  id: emitenteEntity.id,
                  razaoSocial: empresaDto.nomeRazaoSocial,
                  nomeFantasia: empresaDto.nomeFantasia,
                  cnpjCpf: empresaDto.cpfCnpj,
                  ie: empresaDto.inscricaoEstadual,
                  crt: empresaConfiguracaoNfceDto.crt.toString(),
                  csc: empresaConfiguracaoNfceDto.sefaz.csc,
                  idCsc: empresaConfiguracaoNfceDto.sefaz.idCsc.toString(),
                  cep: empresaDto.endereco.cep,
                  logradouro: empresaDto.endereco.logradouro,
                  numero: empresaDto.endereco.numero,
                  complemento: '',
                  bairro: empresaDto.endereco.bairro,
                  codigoMunicipio: empresaDto.endereco.codigoMunicipio,
                  municipio: empresaDto.endereco.cidade,
                  uf: empresaDto.endereco.uf,
                  fone: empresaDto.fone,
                );

                await Get.find<PaygoDatabaseRepository>().emitente.update(
                      emitenteEntity,
                    );
              }

              emitenteEntity = await Get.find<PaygoDatabaseRepository>().emitente.listarPorCpfCnpj(empresaDto.cpfCnpj);

              emitenteId = emitenteEntity!.id;

              // Cadastrando as configurações

              ConfiguracoesEntity? configuracoesEntity =
                  await Get.find<PaygoDatabaseRepository>().configuracoes.listarPorId(1);

              if (configuracoesEntity == null) {
                await Get.find<PaygoDatabaseRepository>().configuracoes.insert(
                      ConfiguracoesEntity(
                        emitenteId: emitenteEntity.id,
                        ambiente: empresaConfiguracaoNfceDto.ambiente,
                        serieNfce: '0',
                        ultimaNfce: 0,
                        arquivoCertificado: '',
                      ),
                    );
              } else {
                configuracoesEntity = ConfiguracoesEntity(
                  emitenteId: emitenteEntity.id,
                  ambiente: empresaConfiguracaoNfceDto.ambiente,
                  serieNfce: '0',
                  ultimaNfce: 0,
                  arquivoCertificado: '',
                );

                await Get.find<PaygoDatabaseRepository>().configuracoes.update(
                      configuracoesEntity,
                    );
              }

              // Cadastrando o usuário administrador

              UsuarioEntity? usuarioEntity = await Get.find<PaygoDatabaseRepository>().usuario.listarPorId(1);

              if (usuarioEntity == null) {
                await Get.find<PaygoDatabaseRepository>().usuario.insert(
                      UsuarioEntity(
                        nome: 'Administrador',
                        login: 'admin',
                        senha: 'admin',
                        emitenteId: emitenteEntity.id,
                      ),
                    );
              } else {
                usuarioEntity = UsuarioEntity(
                  id: usuarioEntity.id,
                  nome: 'Administrador',
                  login: 'admin',
                  senha: 'admin',
                  emitenteId: emitenteEntity.id,
                );

                await Get.find<PaygoDatabaseRepository>().usuario.update(
                      usuarioEntity,
                    );
              }

              // Atualizando a configuração de empresa identificada

              ConfiguracoesSharedModel configuracoesModel = Get.find<ConfiguracoesSharedModel>();
              configuracoesModel.empresaIdentificada = true;
              configuracoesModel.emitenteId = emitenteEntity.id;
              configuracoesModel.ambiente = empresaConfiguracaoNfceDto.ambiente;

              Get.find<ConfiguracoesSharedModel>().updateData(configuracoesModel);
              await Get.find<ConfiguracoesRepository>().setConfiguration(configuracoesModel);

              await Future.delayed(Duration(seconds: 1));

              // Iniciando o banco de dados

              loadingTextSetter(
                'Inicializando o banco de dados',
                true,
                true,
              );

              await inicalizarTabelas(emitenteId);

              await Future.delayed(Duration(seconds: 1));

              // Carregando as tabelas de configuração

              loadingTextSetter(
                'Carregando configuração incial',
                true,
                true,
              );

              await Future.delayed(Duration(seconds: 1));

              // Finalizando a operação

              loadingTextSetter(
                'Dados atualizandos, iniciando o aplicativo',
                false,
                true,
              );

              _cnpjValidateString.value = '';
            } on DioError catch (e) {
              if (e.error != null) {
                _cnpjValidateString.value = 'CNPJ Inválido ou não cadastrado';
              }

              loadingTextSetter(
                'Empresa não identificada\nVerifique o CNPJ informado',
                true,
                false,
              );

              await Future.delayed(Duration(seconds: 2));

              loadingTextSetter(
                'Cancelando operação',
                false,
                false,
              );

              _formKey.currentState!.validate();
            }
          },
        },
      );
    }
  }

  String? cnpjEmpresaValidator(String? value) {
    if (_cnpjValidateString.isNotEmpty) {
      return _cnpjValidateString.value;
    }

    if (value == null || value.isEmpty) {
      return 'Informe o CNPJ da empresa';
    }

    return null;
  }

  void cnpjEmpresaChange(String value) {
    cnpjEmpresa = value.replaceAll(RegExp(r'[^\d]+'), '');
  }

  void abrirUrl() {}
}
