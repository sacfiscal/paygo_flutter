import 'dart:convert';

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paygo_app/infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/cnpj_listar_empresa_dto.dart';
import 'package:paygo_app/infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/service/documentos_eletronicos_service.dart';

import '../../../../../domain/models/shared_preferences/configuracoes_shared_model.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/empresa_configuracao_nfce_dto.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/empresa_dto.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/nfce_pedido_emissao_dto.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_autorizacao_dto.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_cancelamento_dto.dart';
import '../../../../services/api/nuvem_fiscal/documentos_eletronicos/dto/retorno_inutilizacao_dto.dart';

part 'documentos_eletronicos_repository_private.dart';

class DocumentosEletronicosRepository {
  final IDocumentosEletronicosCnpjRepository _cnpj = _DocumentosEletronicosCnpjRepository();
  final IDocumentosEletronicosRepositoryEmpresa _empresa = _DocumentosEletronicosRepositoryEmpresa();
  final IDocumentosEletronicosRepositoryNfce _nfce = _DocumentosEletronicosRepositoryNfce();

  IDocumentosEletronicosCnpjRepository get cnpj => _cnpj;
  IDocumentosEletronicosRepositoryEmpresa get empresa => _empresa;
  IDocumentosEletronicosRepositoryNfce get nfce => _nfce;

  Future<String> cep(String cep) async {
    var resultado = await Get.find<DocumentosEletronicosService>().cep(
      authorization: Get.find<ConfiguracoesSharedModel>().getAuthorization,
      cep: cep,
    );

    Get.find<Logger>().i('\nObtendo um endereço com base no CEP informado\n\n ${resultado.toString()}');

    return resultado;
  }
}
