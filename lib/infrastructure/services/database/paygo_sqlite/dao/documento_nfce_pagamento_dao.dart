import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_pagamento_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class DocumentoNfcePagamentoDao extends ISQLiteDAO<DocumentoNfcePagamentoEntity> {
  @Query(
    '''
    select *
      from documentoNfcePagamento
  ''',
  )
  Future<List<DocumentoNfcePagamentoEntity>?> listar();

  @Query(
    '''
    select *
      from documentoNfcePagamento
     where documentoNfcePagamento.id = :id
  ''',
  )
  Future<DocumentoNfcePagamentoEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from documentoNfcePagamento
     where documentoNfcePagamento.documentoId = :documentoId
  ''',
  )
  Future<DocumentoNfcePagamentoEntity?> listarPorIdDocumento(
    int documentoId,
  );
}
