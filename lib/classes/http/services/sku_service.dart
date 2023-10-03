import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/sku.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class SkuService extends APIService {
  /*Future<List<Sku>> list(List<int> lstCategoryIds) async {
    List<Sku> result = [];
    for (var i = 0; i < lstCategoryIds.length; i++) {
      var parameters = {"category_id": lstCategoryIds[i].toString()};
      result.addAll(Sku.parseModelList(await responseToModelList(
          Constants.API_REQUEST_SKU_LIST, parameters)));
    }
    return result;
  }*/
  Future<List<Sku>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<Sku> result = Sku.parseModelList(
        await responseToModelList(Constants.API_REQUEST_SKU_LIST, parameters));
    return result;
  }

  Future<void> upload(int syncId, List<Sku> data) async {
    var parsedData = [];
    for (var i = 0; i < data.length; i++) {
      parsedData.add({
        "temp_id": data[i].id,
        "name": data[i].name.toString(),
        "category_id": data[i].categoryId,
        "annotations": data[i].annotations.toString(),
      });
    }
    var parameters = {"synchronization_id": syncId, "skus": parsedData};
    await responseSimple(Constants.API_REQUEST_SKUS_UPLOAD, parameters);
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Sku(
        id: int.parse(json["sku_id"].toString()),
        referenceSkuId: (json["reference_sku_id"] == null
            ? 0
            : int.parse(json["reference_sku_id"].toString())),
        categoryId: int.parse(json["category_id"].toString()),
        name: json["name"],
        isPrioritized: int.parse((json["is_prioritized"] ?? "0").toString()));
  }
}
