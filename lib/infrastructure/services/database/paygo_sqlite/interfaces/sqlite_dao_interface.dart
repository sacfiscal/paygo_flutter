import 'package:floor/floor.dart';

abstract class ISQLiteDAO<T> {
  @insert
  Future<void> insertData(T entityInstance);

  @insert
  Future<void> insertListData(List<T> entityInstance);

  @delete
  Future<void> deleteData(T entityInstance);

  @update
  Future<void> updateData(T entityInstance);

  @update
  Future<void> updateListData(List<T> entityInstance);
}
