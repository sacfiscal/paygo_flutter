import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/configuracoes_entity.dart';

@dao
abstract class ConfiguracoesDao extends ISQLiteDAO<ConfiguracoesEntity> {
  @Query(
    '''
    select *
      from configuracoes
  ''',
  )
  Future<List<ConfiguracoesEntity>?> listar();

  @Query(
    '''
    select *
      from configuracoes
     where configuracoes.id = :id
  ''',
  )
  Future<ConfiguracoesEntity?> listarPorId(
    int id,
  );
}
