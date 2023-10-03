import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:lya_encuestas/classes/database/models/answer.dart';

class AnswerDA extends BaseDA {
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
    AnswerDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_ANSWERS;
  }

  @override
  Answer fillModelData(Map<String, dynamic> data) {
    return Answer(
      id: data['id'],
      periodId: data['period_id'],
      sellPointId: data['sell_point_id'],
      skuId: data['sku_id'],
      surveyId: data['survey_id'],
      price: data['price'],
      closedInventory: data['closed_inventory'],
      openInventory: data['open_inventory'],
      purchase: data['purchase'],
      estimatedSale: data['estimated_sale'],
      syncPollsterFirstName: data['sync_pollster_first_name'],
      syncPollsterLastName: data['sync_pollster_last_name'],
      syncPollsterEmail: data['sync_pollster_email'],
      syncRequestDate: data['sync_request_date'],
    );
  }
}
