import 'dart:math' as math;

import 'package:diacritic/diacritic.dart';
import 'package:get/get.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/destinatario_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_item_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/emitente_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/produto_entity.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/uf_entity.dart';

import '../../infrastructure/repositories/database/paygo_sqlite/paygo_database_repository.dart';
import '../../infrastructure/services/api/nuvem_fiscal/documentos_eletronicos/dto/nfce_pedido_emissao_dto.dart';
import '../../infrastructure/services/database/paygo_sqlite/entities/configuracoes_entity.dart';
import '../types/ambiente.dart';
import 'funcoes_datetime.dart';

Future<NfcePedidoEmissaoDto> gerarNfce(int documentoId) async {
  PaygoDatabaseRepository paygoDatabaseRepository = Get.find<PaygoDatabaseRepository>();
  ConfiguracoesEntity? configuracoesEntity;
  EmitenteEntity? emitenteEntity;
  UfEntity? ufEntity;
  DocumentoNfceEntity? documentoNfceEntity;
  List<DocumentoNfceItemEntity>? documentoNfceItemEntity;
  DocumentoNfcePagamentoEntity? documentoNfcePagamentoEntity;
  DestinatarioEntity? destinatarioEntity;

  configuracoesEntity = await paygoDatabaseRepository.configuracoes.listarPorId(1);
  emitenteEntity = await paygoDatabaseRepository.emitente.listarPorId(configuracoesEntity!.emitenteId!);
  ufEntity = await paygoDatabaseRepository.uf.listarPorSigla(emitenteEntity!.uf!);

  documentoNfceEntity = await paygoDatabaseRepository.documentoNFCE.listarPorId(
    int.tryParse(
      obterAmbienteFromDisplay(
        configuracoesEntity.ambiente!,
      ).value.toString(),
    )!,
    documentoId,
  );

  documentoNfceItemEntity = await paygoDatabaseRepository.documentoNFCeItem.listarPorIdDocumento(
    documentoId,
  );

  int nfceCnf = 0;

  while (nfceCnf.toString().length != 8) {
    nfceCnf = math.Random().nextInt(99999999);
  }

  Ide ide = Ide(
    cUf: ufEntity!.codigoIbge!,
    cNf: nfceCnf.toString(),
    natOp: 'VENDA',
    mod: documentoNfceEntity!.mod!,
    serie: documentoNfceEntity.serie!,
    nNf: documentoNfceEntity.nNF!,
    dhEmi: dateToNFe(DateTime.now().toUtc()),
    dhSaiEnt: dateToNFe(DateTime.now().toUtc()),
    tpNf: 1,
    idDest: 1,
    cMunFg: emitenteEntity.codigoMunicipio!,
    tpImp: documentoNfceEntity.tpImp!,
    tpEmis: documentoNfceEntity.tpEmis!,
    cDv: 0,
    tpAmb: documentoNfceEntity.tpAmb!,
    finNFe: documentoNfceEntity.finNFe!,
    indFinal: documentoNfceEntity.indFinal!,
    indPres: documentoNfceEntity.indPres!,
    indIntermed: 0,
    procEmi: 0,
    verProc: 'PayGO_Flutter',
  );

  Emit emit = Emit(
    cnpj: emitenteEntity.cnpjCpf!,
    xNome: emitenteEntity.razaoSocial!,
    xFant: emitenteEntity.nomeFantasia!,
    enderEmit: Ender(
      xLgr: emitenteEntity.logradouro!,
      nro: emitenteEntity.numero!,
      xCpl: (emitenteEntity.complemento!.trim() != '') ? emitenteEntity.complemento!.trim() : null,
      xBairro: emitenteEntity.bairro!,
      cMun: emitenteEntity.codigoMunicipio!,
      xMun: emitenteEntity.municipio!,
      uf: emitenteEntity.uf!,
      cep: emitenteEntity.cep!,
      cPais: '1058',
      xPais: 'BRASIL',
      fone: emitenteEntity.fone!,
    ),
    ie: emitenteEntity.ie!.replaceAll(RegExp(r'[^\d]+'), ''),
    crt: int.tryParse(emitenteEntity.crt!)!,
  );

  Dest? dest;

  if (documentoNfceEntity.destinatarioId != null) {
    destinatarioEntity = await paygoDatabaseRepository.destinatario.listarPorId(
      documentoNfceEntity.destinatarioId!,
    );

    if (destinatarioEntity!.cnpjCpf!.length == 11) {
      dest = Dest(
        cpf: destinatarioEntity.cnpjCpf!,
        indIeDest: 9,
      );
    } else {
      dest = Dest(
        cnpj: destinatarioEntity.cnpjCpf!,
        indIeDest: 9,
      );
    }
  } else {
    if (documentoNfceEntity.cnpjCpf != null) {
      if (documentoNfceEntity.cnpjCpf!.length == 11) {
        dest = Dest(
          cpf: documentoNfceEntity.cnpjCpf!,
          indIeDest: 9,
        );
      } else {
        dest = Dest(
          cnpj: documentoNfceEntity.cnpjCpf!,
          indIeDest: 9,
        );
      }
    }
  }

  List<Det> listDet = [];

  int itemNfce = 0;

  for (DocumentoNfceItemEntity item in documentoNfceItemEntity!) {
    ProdutoEntity? produtoEntity;
    produtoEntity = await paygoDatabaseRepository.produto.listarPorId(item.produtoId!);

    itemNfce++;

    listDet.add(
      Det(
        nItem: itemNfce,
        prod: Prod(
          cProd: item.cProd.toString(),
          cEan: produtoEntity!.cean!,
          xProd: produtoEntity.descricao!,
          ncm: produtoEntity.ncm!,
          cest: produtoEntity.cest!,
          cfop: produtoEntity.cfop!,
          uCom: produtoEntity.unidade!,
          qCom: item.qCom!,
          vUnCom: item.vUnCom!,
          vProd: item.vProd!,
          cEanTrib: produtoEntity.cean!,
          uTrib: produtoEntity.unidade!,
          qTrib: item.qCom!,
          vUnTrib: item.vUnCom!,
          indTot: 1,
        ),
        imposto: Imposto(
          vTotTrib: 0,
          icms: Icms(
            icmssn102: Icmssn102(
              orig: int.tryParse(produtoEntity.origem!)!,
              csosn: int.tryParse(produtoEntity.cstIcms!)!,
            ),
          ),
        ),
      ),
    );
  }

  Total total = Total(
    icmsTot: IcmsTot(
      vBc: 0,
      vIcms: 0,
      vIcmsDeson: 0,
      vFcpufDest: 0,
      vIcmsufDest: 0,
      vIcmsufRemet: 0,
      vFcp: 0,
      vBcst: 0,
      vSt: 0,
      vFcpst: 0,
      vFcpstRet: 0,
      vProd: documentoNfceEntity.vProd!,
      vFrete: documentoNfceEntity.vFrete!,
      vSeg: documentoNfceEntity.vSeg!,
      vDesc: documentoNfceEntity.vDesc!,
      vIi: 0,
      vIpi: 0,
      vIpiDevol: 0,
      vPis: 0,
      vCofins: 0,
      vOutro: documentoNfceEntity.vOutro!,
      vNf: documentoNfceEntity.vNF!,
      vTotTrib: 0,
    ),
  );

  Transp transp = Transp(
    modFrete: 9,
  );

  documentoNfcePagamentoEntity = await paygoDatabaseRepository.documentoNFCePagamento.listarPorIdDocumento(
    documentoId,
  );

  Pag pag = Pag(
    detPag: [
      DetPag(
        tPag: documentoNfcePagamentoEntity!.tPag!,
        vPag: documentoNfcePagamentoEntity.vPag!,
      ),
    ],
    vTroco: 0,
  );

  NfcePedidoEmissaoDto body = NfcePedidoEmissaoDto(
    ambiente: obterAmbienteDisplay(removeDiacritics(configuracoesEntity.ambiente!.toLowerCase())).toLowerCase(),
    infNFe: InfNFe(
      versao: '4.00',
      ide: ide,
      emit: emit,
      dest: dest,
      det: listDet,
      total: total,
      transp: transp,
      pag: pag,
      infAdic: InfAdic(
        infCpl: '.',
      ),
    ),
  );

  return body;
}
