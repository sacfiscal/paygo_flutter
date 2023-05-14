import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paygo_app/commons/types/indiedest.dart';
import 'package:paygo_app/domain/models/databaase/paygo_sqlite/destinatario_model.dart';
import 'package:paygo_app/infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/destinatario_entity.dart';
import 'package:search_cep/search_cep.dart';

import '../../../commons/components/pesquisas/pesquisa.dart';
import '../../../commons/style/application_colors.dart';
import '../../../infrastructure/repositories/api/nuvem_fiscal/documentos_eletronicos/documentos_eletronicos_repository.dart';
import '../../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/cnpj_listar_empresa_dto.dart';

class ClienteController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  final _isLoadList = true.obs;
  final _campoBusca = ''.obs;

  final destinatario = DestinatarioModel().obs;

  Rx<List<DestinatarioModel>> list = Rx<List<DestinatarioModel>>([]);

  GlobalKey<FormState> get formKey => _formKey;

  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  get isLoadList => _isLoadList.value;
  set isLoadList(value) => _isLoadList.value = value;

  get campoBusca => _campoBusca.value;
  set campoBusca(value) => _campoBusca.value = value;

  void buscaCadastro() async {
    try {
      DocumentosEletronicosRepository documentosEletronicosRepository = Get.find<DocumentosEletronicosRepository>();

      CnpjListarEmpresaDto empresaDto = await documentosEletronicosRepository.cnpj.consultarCnpj(
        cnpj: destinatario.value.cnpjCpf!,
      );

      destinatario.update(
        (destinatario) {
          destinatario?.cnpjCpf = empresaDto.cnpj;
          destinatario?.razaoSocial = empresaDto.razaoSocial ?? '';
          destinatario?.nomeFantasia = empresaDto.nomeFantasia;
          destinatario?.cep = empresaDto.endereco?.cep;
          destinatario?.logradouro = empresaDto.endereco?.logradouro;
          destinatario?.numero = empresaDto.endereco?.numero;
          destinatario?.bairro = empresaDto.endereco?.bairro;
          destinatario?.municipio = empresaDto.endereco?.municipio?.descricao;
          destinatario?.uf = empresaDto.endereco?.uf;
          destinatario?.codigoMunicipio = empresaDto.endereco?.municipio?.codigoIbge;
          destinatario?.fone = '${empresaDto.telefones?[0].ddd}${empresaDto.telefones?[0].numero}';
          destinatario?.email = empresaDto.email;
        },
      );
    } on DioError catch (e) {
      Get.snackbar(
        'Erro',
        e.message ?? 'Erro ao buscar cadastro',
        backgroundColor: ApplicationColors.paygoTomato.withAlpha(190),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 90),
        duration: Duration(
          seconds: 1,
        ),
      );
    }
  }

  void buscaCep() async {
    final viaCepSearchCep = ViaCepSearchCep();

    Either<SearchCepError, ViaCepInfo> infoCep = await viaCepSearchCep.searchInfoByCep(
      cep: destinatario.value.cep!,
    );

    ViaCepInfo? cep;
    SearchCepError? error;

    infoCep.fold(
      (l) {
        error = l;
        Get.snackbar(
          'Erro',
          error?.errorMessage ?? 'Erro ao buscar CEP',
          backgroundColor: ApplicationColors.paygoTomato.withAlpha(190),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 90),
          duration: Duration(
            seconds: 1,
          ),
        );
      },
      (r) => cep = r,
    );

    if (cep != null) {
      destinatario.update(
        (destinatario) {
          destinatario?.cep = cep?.cep;
          destinatario?.logradouro = cep?.logradouro;
          destinatario?.bairro = cep?.bairro;
          destinatario?.municipio = cep?.localidade;
          destinatario?.uf = cep?.uf;
          destinatario?.codigoMunicipio = cep?.unidade;
        },
      );
    }
  }

  Future<void> buscarindIeDest(var context) async {
    List<Indiedest> listaOrigem = [
      Indiedest.contribuinteIcms,
      Indiedest.contribuinteIsento,
      Indiedest.naoContribuinte,
    ];

    Map<String, dynamic> resultadoBusca = await showSearch(
      context: context,
      delegate: PesquisaWidget(
        listaOrigem
            .map(
              (e) => {
                "display": e.display,
                "value": e.value,
              },
            )
            .toList(),
      ),
    );

    destinatario.update(
      (campoUpdate) {
        campoUpdate!.indIeDest = resultadoBusca['value'].toString();
      },
    );
  }

  Future<void> carregarLista() async {
    isLoadList = true;

    await Future.delayed(const Duration(
      milliseconds: 300,
    ));

    try {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      List<DestinatarioEntity>? result = await paygoDatabaseRepository.destinatario.listar();

      List<DestinatarioModel> listAux = [];
      listAux.addAll(result!.map((e) => DestinatarioModel.fromJson(e.toJson())).toList());

      list.value.clear();

      if (campoBusca.trim() != '') {
        list.value.addAll(
          listAux.where((element) {
            return ((element.razaoSocial.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.nomeFantasia.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    ) ||
                element.cnpjCpf.toString().toLowerCase().contains(
                      campoBusca.toLowerCase(),
                    )));
          }),
        );
      } else {
        list.value.addAll(listAux);
      }
    } finally {
      isLoadList = false;
    }
  }

  Future<void> excluirRegistro() async {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Excluir',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(25, 15, 25, 6),
        backgroundColor: ApplicationColors.paygoDark,
        titleTextStyle: TextStyle(
          color: ApplicationColors.paygoYellow,
        ),
        content: const Text(
          'Deseja realmente excluir o registro?',
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: ApplicationColors.paygoYellow,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Não',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ApplicationColors.paygoYellow,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
              DestinatarioEntity destinatarioEntity = DestinatarioEntity.fromJson(destinatario.toJson());
              paygoDatabaseRepository.destinatario.delete(destinatarioEntity);
              Get.back();
              Get.back();
            },
            child: const Text(
              'Sim',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.redAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void salvarRegistro() async {
    if (formKey.currentState!.validate()) {
      PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
      DestinatarioEntity? destinatarioEntity = DestinatarioEntity.fromJson(destinatario.value.toJson());

      if (destinatarioEntity.id == null) {
        paygoDatabaseRepository.destinatario.insert(destinatarioEntity);
      } else {
        paygoDatabaseRepository.destinatario.update(destinatarioEntity);
      }

      destinatarioEntity = await paygoDatabaseRepository.destinatario.listarPorCnpjCpf(
        destinatario.value.cnpjCpf!,
      );

      destinatario.value = DestinatarioModel.fromJson(destinatarioEntity!.toJson());

      destinatario.update((val) {
        val!.id = destinatarioEntity!.id;
      });

      Get.back();
    }
  }

  @override
  void onInit() async {
    await carregarLista();
    super.onInit();
  }
}
