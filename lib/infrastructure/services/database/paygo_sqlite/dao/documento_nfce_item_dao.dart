import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_item_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class DocumentoNfceItemDao extends ISQLiteDAO<DocumentoNfceItemEntity> {
  @Query(
    '''
    select *
      from documentoNfceItem
  ''',
  )
  Future<List<DocumentoNfceItemEntity>?> listar();

  @Query(
    '''
    select *
      from documentoNfceItem
     where documentoNfceItem.id = :id
  ''',
  )
  Future<DocumentoNfceItemEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select documentoNfceItem.*,
           produto.descricao as produtoDescricao
      from documentoNfceItem
      join produto on produto.id = documentoNfceItem.produtoId
     where documentoNfceItem.documentoId = :documentoId
  ''',
  )
  Future<List<DocumentoNfceItemEntity>?> listarPorIdDocumento(
    int documentoId,
  );
}
