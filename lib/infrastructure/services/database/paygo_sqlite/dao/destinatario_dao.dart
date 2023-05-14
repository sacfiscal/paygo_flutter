import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/destinatario_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class DestinatarioDao extends ISQLiteDAO<DestinatarioEntity> {
  @Query(
    '''
    select *
      from destinatario
  ''',
  )
  Future<List<DestinatarioEntity>?> listar();

  @Query(
    '''
    select *
      from destinatario
     where destinatario.id = :id
  ''',
  )
  Future<DestinatarioEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from destinatario
     where destinatario.cnpjCpf = :cnpjCpf
  ''',
  )
  Future<DestinatarioEntity?> listarPorCnpjCpf(
    String cnpjCpf,
  );

  @Query(
    '''
    select *
      from bandeiraCartao
     where bandeiraCartao.razaoSocial = '%' || :razaoSocial || '%'
  ''',
  )
  Future<DestinatarioEntity?> listarPorRazaoSocial(
    String razaoSocial,
  );
}
