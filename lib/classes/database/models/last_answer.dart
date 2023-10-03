import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class LastAnswer extends BaseModel {
  int workOrderId;
  String workOrderCode;
  String frecuencyTypeCode;
  String frecuencyTypeName;
  int surveyId;
  String surveyTypeCode;
  String surveyTypeName;
  String periodCode;
  String periodName;
  int categoryId;
  int surveyConfigTypeId;
  String surveyConfigTypeCode;
  String surveyConfigTypeName;
  int sellPointId;
  int skuId;
  String answers;

  LastAnswer({
    required this.workOrderId,
    required this.workOrderCode,
    required this.frecuencyTypeCode,
    required this.frecuencyTypeName,
    required this.surveyId,
    required this.surveyTypeCode,
    required this.surveyTypeName,
    required this.periodCode,
    required this.periodName,
    required this.categoryId,
    required this.surveyConfigTypeId,
    required this.surveyConfigTypeCode,
    required this.surveyConfigTypeName,
    required this.sellPointId,
    required this.skuId,
    required this.answers,
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      'work_order_id': workOrderId,
      'work_order_code': workOrderCode,
      'frecuency_type_code': frecuencyTypeCode,
      'frecuency_type_name': frecuencyTypeName,
      'survey_id': surveyId,
      'survey_type_code': surveyTypeCode,
      'survey_type_name': surveyTypeName,
      'period_code': periodCode,
      'period_name': periodName,
      'category_id': categoryId,
      'survey_config_type_id': surveyConfigTypeId,
      'survey_config_type_code': surveyConfigTypeCode,
      'survey_config_type_name': surveyConfigTypeName,
      'sell_point_id': sellPointId,
      'sku_id': skuId,
      'answers': answers,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static LastAnswer? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is LastAnswer) return data;
    return null;
  }

  static List<LastAnswer> parseModelList(List<BaseModel> data) {
    List<LastAnswer> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as LastAnswer);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
