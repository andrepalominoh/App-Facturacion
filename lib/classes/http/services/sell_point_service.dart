import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class SellPointService extends APIService {
  Future<List<SellPoint>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<SellPoint> result = SellPoint.parseModelList(await responseToModelList(
        Constants.API_REQUEST_SELLPOINT_LIST, parameters));
    return result;
  }

  Future<void> upload(int syncId, List<SellPoint> data) async {
    var parsedData = [];
    for (var i = 0; i < data.length; i++) {
      parsedData.add({
        "temp_id": data[i].id,
        "name": data[i].name,
        "address": data[i].address,
        "location_id": data[i].districtId,
        "channel_id": data[i].channelId,
        "contact_name": data[i].contactName,
        "contact_phone": data[i].contactPhone,
        "annotations": data[i].annotations,
      });
    }
    var parameters = {"synchronization_id": syncId, "sell_points": parsedData};
    await responseSimple(Constants.API_REQUEST_SELL_POINTS_UPLOAD, parameters);
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return SellPoint(
        id: int.parse(json["sell_point_id"].toString()),
        referenceSellPointId: (json["reference_sell_point_id"] == null
            ? 0
            : int.parse(json["reference_sell_point_id"].toString())),
        districtId: int.parse(json["location_id"].toString()),
        channelId: int.parse(json["channel_id"].toString()),
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        contactName: json["contact_name"] ?? "",
        contactPhone: json["contact_phone"] ?? "");
  }
}
