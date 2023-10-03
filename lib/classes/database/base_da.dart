import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/assets/utils.dart';
import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDA {
  Future<BaseModel?> insert(BaseModel obj) async {
    var db = await DBManager.instance.database;

    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.insert(
        getTable(),
        obj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      batch.commit();
    });
    Map<String, dynamic> data = obj.toMap();
    return await get(int.parse(data["id"].toString()));
  }

  Future<void> insertMultiple(List<BaseModel> lst) async {
    var db = await DBManager.instance.database;

    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var i = 0; i < lst.length; i++) {
        batch.insert(
          getTable(),
          lst[i].toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      batch.commit();
    });
  }

  Future<void> insertBackMultiple(List<BaseModel> lst, int syncId) async {
    var db = await DBManager.instance.database;
    final syncData = <String, dynamic>{
      "sync_id": syncId,
      "backuped_at": Utils.getDateTime()
    };
    await db.transaction((txn) async {
      var batch = txn.batch();
      for (var i = 0; i < lst.length; i++) {
        var map = lst[i].toMap();
        map.addEntries(syncData.entries);
        batch.insert(
          Constants.DB_TABLE_BACK_IDENTIFIER + getTable(),
          map,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      batch.commit();
    });
  }

  Future<List<BaseModel>> list(String? where, String? orderBy) async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data = await db.query(getTable(),
        where: (where ?? "1=1"), orderBy: (orderBy ?? "id asc"));

    return List.generate(data.length, (i) {
      return fillModelData(data[i]);
    });
  }

  Future<BaseModel?> first(String? where) async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data =
        await db.query(getTable(), where: (where ?? "1=1"));
    if (data.isNotEmpty) {
      return fillModelData(data[0]);
    } else {
      return null;
    }
  }

  Future<BaseModel?> get(int id) async {
    final List<BaseModel> data = await list("id = " + id.toString(), null);

    if (data.length == 1) {
      return data[0];
    } else {
      return null;
    }
  }

  Future<void> delete(int? id) async {
    var db = await DBManager.instance.database;

    await db.transaction((txn) async {
      var batch = txn.batch();
      if (id == null) {
        batch.delete(getTable());
      } else {
        batch.delete(
          getTable(),
          where: 'id = ?',
          whereArgs: [id],
        );
      }
      batch.commit();
    });
  }

  Future<void> deleteWhere(String? where) async {
    var db = await DBManager.instance.database;

    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(
        getTable(),
        where: where,
      );
      batch.commit();
    });
  }

  /// **************************************************************************/
  String getTable();
  BaseModel fillModelData(Map<String, dynamic> data);
}
