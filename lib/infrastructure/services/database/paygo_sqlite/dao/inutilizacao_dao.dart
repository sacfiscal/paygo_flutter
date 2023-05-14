import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/inutilizacao_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class InutilizacaoDao extends ISQLiteDAO<InutilizacaoEntity> {
  @Query(
    '''
    select *
      from inutilizacao
     where inutilizacao.tpAmb = :tpAmb
  ''',
  )
  Future<List<InutilizacaoEntity>?> listar(
    int tpAmb,
  );
}
