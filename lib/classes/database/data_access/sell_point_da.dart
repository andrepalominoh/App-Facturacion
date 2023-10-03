import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';

class SellPointDA extends BaseDA {
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
  
  Future<void> deleteAllBase() async {
    SellPointDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_SELLPOINTS;
  }

  @override
  SellPoint fillModelData(Map<String, dynamic> data) {
    return SellPoint(
      id: data['id'],
      referenceSellPointId: data['reference_sell_point_id'],
      districtId: data['district_id'],
      channelId: data['channel_id'],
      name: data['name'],
      address: data['address'],
      contactName: data['contact_name'],
      contactPhone: data['contact_phone'],
      annotations: data['annotations']
    );
  }
}
