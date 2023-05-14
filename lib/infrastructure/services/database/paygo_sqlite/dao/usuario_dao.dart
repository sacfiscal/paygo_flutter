import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/usuario_entity.dart';

@dao
abstract class UsuarioDao extends ISQLiteDAO<UsuarioEntity> {
  @Query(
    '''
    select *
      from usuario
  ''',
  )
  Future<List<UsuarioEntity>?> listar();

  @Query(
    '''
    select *
      from usuario
     where usuario.id = :id
  ''',
  )
  Future<UsuarioEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from usuario
     where usuario.nome = '%' || :nome || '%'
  ''',
  )
  Future<UsuarioEntity?> listarPorNome(
    String nome,
  );

  @Query(
    '''
    select *
      from usuario
     where usuario.login = :login
  ''',
  )
  Future<UsuarioEntity?> listarPorLogin(
    String login,
  );
}
