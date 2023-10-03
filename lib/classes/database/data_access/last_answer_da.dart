import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/db_manager.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';

class LastAnswerDA extends BaseDA {
  final String preQuery = " SELECT "
      "   work_order_id,"
      "   min(work_order_code) as work_order_code,"
      "   min(frecuency_type_code) as frecuency_type_code,"
      "   min(frecuency_type_name) as frecuency_type_name,"
      "   survey_id,"
      "   min(survey_type_code) as survey_type_code,"
      "   min(survey_type_name) as survey_type_name,"
      "   period_code,"
      "   min(period_name) as period_name,"
      "   category_id,"
      "   min(survey_config_type_id) as survey_config_type_id,"
      "   min(survey_config_type_code) as survey_config_type_code,"
      "   min(survey_config_type_name) as survey_config_type_name,"
      "   min(sell_point_id) as sell_point_id,"
      "   min(sku_id) as sku_id,"
      "   min(answers) as answers";

  Future<void> deleteAllBase() async {
    LastAnswerDA().delete(null);
  }

  Future<List<LastAnswer>> getBySellPointAndSkuGroupedBySurvey(
      String periodCode, int sellPointId, int skuId) async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data = await db.rawQuery(preQuery +
        " FROM ${getTable()}"
            " WHERE sell_point_id = ${sellPointId.toString()} and sku_id = ${skuId.toString()} and period_code = $periodCode"
            " GROUP BY"
            "   work_order_id,period_code,survey_id,category_id");
    return List.generate(data.length, (i) {
      return fillModelData(data[i]);
    });
  }

  Future<List<LastAnswer>> getBySellPointAndCategoryGroupedBySurvey(
      String periodCode, int sellPointId, int categoryId) async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data = await db.rawQuery(preQuery +
        " FROM ${getTable()}"
            " WHERE sell_point_id = ${sellPointId.toString()} and category_id = ${categoryId.toString()} and period_code = $periodCode"
            " GROUP BY"
            "   work_order_id,period_code,survey_id,category_id");
    return List.generate(data.length, (i) {
      return fillModelData(data[i]);
    });
  }

  Future<List<LastAnswer>> getByNewSellPointAndCategoryGroupedBySurvey(
      String periodCode, int categoryId) async {
    var db = await DBManager.instance.database;
    final List<Map<String, dynamic>> data = await db.rawQuery(preQuery +
        " FROM ${getTable()}"
            " WHERE category_id = ${categoryId.toString()} and period_code = $periodCode"
            " GROUP BY"
            "   work_order_id,period_code,survey_id,category_id");
    return List.generate(data.length, (i) {
      return fillModelData(data[i]);
    });
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_LAST_ANSWERS;
  }

  @override
  LastAnswer fillModelData(Map<String, dynamic> data) {
    return LastAnswer(
      workOrderId: data["work_order_id"],
      workOrderCode: data["work_order_code"],
      frecuencyTypeCode: data["frecuency_type_code"],
      frecuencyTypeName: data['frecuency_type_name'],
      surveyId: data['survey_id'],
      surveyTypeCode: data['survey_type_code'],
      surveyTypeName: data['survey_type_name'],
      periodCode: data['period_code'],
      periodName: data['period_name'],
      categoryId: data['category_id'],
      surveyConfigTypeId: data['survey_config_type_id'],
      surveyConfigTypeCode: data['survey_config_type_code'],
      surveyConfigTypeName: data['survey_config_type_name'],
      sellPointId: data['sell_point_id'],
      skuId: data['sku_id'],
      answers: data['answers'],
    );
  }
}
