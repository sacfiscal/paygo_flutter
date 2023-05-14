import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/uf_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class UfDao extends ISQLiteDAO<UfEntity> {
  @Query(
    '''
    select *
      from uf
  ''',
  )
  Future<List<UfEntity>?> listar();

  @Query(
    '''
    select *
      from uf
     where uf.id = :id
  ''',
  )
  Future<UfEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from uf
     where uf.sigla = :sigla
  ''',
  )
  Future<UfEntity?> listarPorSigla(
    String sigla,
  );
}
