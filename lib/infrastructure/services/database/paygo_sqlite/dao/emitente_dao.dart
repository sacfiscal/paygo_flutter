import 'package:floor/floor.dart';

import '../interfaces/sqlite_dao_interface.dart';
import '../entities/emitente_entity.dart';

@dao
abstract class EmitenteDao extends ISQLiteDAO<EmitenteEntity> {
  @Query(
    '''
    select *
      from emitente
  ''',
  )
  Future<List<EmitenteEntity>?> listar();

  @Query(
    '''
    select *
      from emitente
     where emitente.id = :id
  ''',
  )
  Future<EmitenteEntity?> listarPorId(
    int id,
  );

  @Query(
    '''
    select *
      from emitente
     where emitente.cnpjCpf = :cnpjCpf
  ''',
  )
  Future<EmitenteEntity?> listarPorCpfCnpj(
    String cnpjCpf,
  );

  @Query(
    '''
    select *
      from emitente
     where emitente.razaoSocial = '%' || :razaoSocial || '%'
  ''',
  )
  Future<EmitenteEntity?> listarPorRazaoSocial(
    String razaoSocial,
  );
}
