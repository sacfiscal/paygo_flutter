import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/bandeira_cartao_entity.dart';

@dao
abstract class BandeiraCartaoDao extends ISQLiteDAO<BandeiraCartaoEntity> {
  @Query(
    '''
    select *
      from bandeiraCartao
  ''',
  )
  Future<List<BandeiraCartaoEntity>?> listar();

  @Query(
    '''
    select *
      from bandeiraCartao
     where bandeiraCartao.id = :id
  ''',
  )
  Future<BandeiraCartaoEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from bandeiraCartao
     where bandeiraCartao.codSefaz = :codSefaz
  ''',
  )
  Future<BandeiraCartaoEntity?> listarPorCodSefaz(
    String codSefaz,
  );

  @Query(
    '''
    select *
      from bandeiraCartao
     where bandeiraCartao.descricao = '%' || :descricao || '%'
  ''',
  )
  Future<BandeiraCartaoEntity?> listarPorDescricao(
    String descricao,
  );
}
