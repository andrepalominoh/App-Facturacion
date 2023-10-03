import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:lya_encuestas/classes/database/models/sku.dart';

class SkuDA extends BaseDA {
  Future<int> getMinID() async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data =
        await db.query(getTable(), orderBy: "id asc");

    if (data.isEmpty) {
      return 0;
    } else {
      return fillModelData(data[0]).id;
    }
  }

  Future<void> setPrioritize(int skuId)async{
    var db = await DBManager.instance.database;
    await db.transaction((txn) async {
      var batch = txn.batch();     
      batch.update(
        getTable(),
        {'is_prioritized':1},
        where: 'id = ?',
        whereArgs: [skuId]);
      batch.commit();
    });
  }

  Future<void> deleteAllBase() async {
    SkuDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_SKUS;
  }

  @override
  Sku fillModelData(Map<String, dynamic> data) {
    return Sku(
      id: data['id'],
      referenceSkuId: data['reference_sku_id'],
      categoryId: data['category_id'],
      name: data['name'],
      annotations: data['annotations'],
      isPrioritized: data['is_prioritized'],
    );
  }
}
