import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/produto_entity.dart';

@dao
abstract class ProdutoDao extends ISQLiteDAO<ProdutoEntity> {
  @Query(
    '''
    select *
      from produto
  ''',
  )
  Future<List<ProdutoEntity>?> listar();

  @Query(
    '''
    select *
      from produto
     where produto.id = :id
  ''',
  )
  Future<ProdutoEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from produto
     where produto.codigo = :codigo
  ''',
  )
  Future<ProdutoEntity?> listarPorCodigo(
    int codigo,
  );

  @Query(
    '''
    select *
      from produto
     where produto.descricao = '%' || :descricao || '%'
  ''',
  )
  Future<ProdutoEntity?> listarPorDescricao(
    String descricao,
  );

  @Query(
    '''
    select *
      from produto
     where produto.cean = '%' || :cean || '%'
  ''',
  )
  Future<ProdutoEntity?> listarPorEan(
    String cean,
  );
}
