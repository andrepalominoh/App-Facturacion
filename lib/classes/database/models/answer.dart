import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Answer extends BaseModel {
  int id;
  int periodId;
  int sellPointId;
  int skuId;
  int surveyId;
  String price;
  String closedInventory;
  String openInventory;
  String purchase;
  String estimatedSale;
  String syncPollsterFirstName;
  String syncPollsterLastName;
  String syncPollsterEmail;
  String syncRequestDate;

  Answer({
    required this.id,
    required this.periodId,
    required this.sellPointId,
    required this.skuId,
    required this.surveyId,
    required this.price,
    required this.closedInventory,
    required this.openInventory,
    required this.purchase,
    required this.estimatedSale,
    required this.syncPollsterFirstName,
    required this.syncPollsterLastName,
    required this.syncPollsterEmail,
    required this.syncRequestDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'period_id': periodId,
      'sell_point_id': sellPointId,
      'sku_id': skuId,
      'survey_id': surveyId,
      'price': price,
      'closed_inventory': closedInventory,
      'open_inventory': openInventory,
      'purchase': purchase,
      'estimated_sale': estimatedSale,
      'sync_pollster_first_name': syncPollsterFirstName,
      'sync_pollster_last_name': syncPollsterLastName,
      'sync_pollster_email': syncPollsterEmail,
      'sync_request_date': syncRequestDate,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Answer? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Answer) return data;
    return null;
  }

  static List<Answer> parseModelList(List<BaseModel> data) {
    List<Answer> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Answer);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
