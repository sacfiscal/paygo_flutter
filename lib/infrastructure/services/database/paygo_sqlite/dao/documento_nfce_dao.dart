import 'package:floor/floor.dart';
import 'package:paygo_app/infrastructure/services/database/paygo_sqlite/entities/documento_nfce_entity.dart';

import '../interfaces/sqlite_dao_interface.dart';

@dao
abstract class DocumentoNfceDao extends ISQLiteDAO<DocumentoNfceEntity> {
  @Query(
    '''
    select documentoNfce.*,
           destinatario.razaoSocial as destinatarioRazaoSocial,
           destinatario.cnpjCpf as destinatarioCnpjCpf
      from documentoNfce
      left outer join destinatario on ( destinatario.id = documentoNfce.destinatarioId )
     where documentoNfce.tpAmb = :tpAmb
  ''',
  )
  Future<List<DocumentoNfceEntity>?> listar(
    int tpAmb,
  );

  @Query(
    '''
    select *
      from documentoNfce
     where documentoNfce.tpAmb = :tpAmb
       and documentoNfce.id = :id
  ''',
  )
  Future<DocumentoNfceEntity?> listarPorId(
    int tpAmb,
    int id,
  );

  @Query(
    '''
    select *
      from documentoNfce
     where documentoNfce.tpAmb = :tpAmb
       and documentoNfce.serie = :serie
       and documentoNfce.nNF = :nNF
  ''',
  )
  Future<DocumentoNfceEntity?> listarPorSerieNf(
    int tpAmb,
    int serie,
    int nNF,
  );
}
