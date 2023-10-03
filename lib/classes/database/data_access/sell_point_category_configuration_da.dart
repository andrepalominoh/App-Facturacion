import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:lya_encuestas/classes/database/models/sell_point_category_configuration.dart';
import 'package:sqflite/sqflite.dart';

class SellPointCategoryConfigurationDA extends BaseDA{

  Future<void> insertRow(SellPointCategoryConfiguration obj) async {
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
  }

  Future<void> update(int sellPointId,values) async {
    var db = await DBManager.instance.database;
    await db.transaction((txn) async {
      var batch = txn.batch();     
      batch.update(
        getTable(),
        values,
        where: 'sell_point_id = ?',
        whereArgs: [sellPointId]);
      batch.commit();
    });
  }


  Future<void> deleteAllBase() async {
    SellPointCategoryConfigurationDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_SELLPOINT_CATEGORY_CONFIGURATIONS;
  }

  @override
  SellPointCategoryConfiguration fillModelData(Map<String, dynamic> data) {
    return SellPointCategoryConfiguration(
      sellPointId: data['sell_point_id'],
      categoryId: data['category_id'],
      categoryName: data['category_name'],
      periodId: data['period_id'],
      statusId:data['status_id'],
      statusCode:data['status_code'],
      statusName: data['status_name'],
      annotations: data['annotations']
    );
  }
}