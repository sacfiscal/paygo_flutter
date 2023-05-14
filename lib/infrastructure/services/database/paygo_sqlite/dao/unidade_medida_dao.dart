import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/unidade_medida_entity.dart';

@dao
abstract class UnidadeMedidaDao extends ISQLiteDAO<UnidadeMedidaEntity> {
  @Query(
    '''
    select *
      from unidadeMedida
  ''',
  )
  Future<List<UnidadeMedidaEntity>?> listar();

  @Query(
    '''
    select *
      from unidadeMedida
     where unidadeMedida.id = :id
  ''',
  )
  Future<UnidadeMedidaEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from unidadeMedida
     where unidadeMedida.sigla = :sigla
       and unidadeMedida.descricao = :descricao
  ''',
  )
  Future<UnidadeMedidaEntity?> listarPorSiglaDescricao(
    String sigla,
    String descricao,
  );
}
