import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/forma_pagamento_entity.dart';

@dao
abstract class FormaPagamentoDao extends ISQLiteDAO<FormaPagamentoEntity> {
  @Query(
    '''
    select *
      from formaPagto
  ''',
  )
  Future<List<FormaPagamentoEntity>?> listar();

  @Query(
    '''
    select *
      from formaPagto
     where formaPagto.id = :id
  ''',
  )
  Future<FormaPagamentoEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from formaPagto
     where formaPagto.codSefaz = :codSefaz
       and formaPagto.descricao = :descricao
  ''',
  )
  Future<FormaPagamentoEntity?> listarPorCodSefazDescricao(
    String codSefaz,
    String descricao,
  );

  @Query(
    '''
    select *
      from formaPagto
     where formaPagto.descricao = '%' || :descricao || '%'
  ''',
  )
  Future<FormaPagamentoEntity?> listarPorDescricao(
    String descricao,
  );
}
