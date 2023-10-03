import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/sell_point_category_configuration.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class SellPointCategoryConfigurationService extends APIService {
  Future<List<SellPointCategoryConfiguration>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<SellPointCategoryConfiguration> result = SellPointCategoryConfiguration.parseModelList(await responseToModelList(
        Constants.API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_LIST_V2, parameters));
    return result;
  }

  Future<void> upload(int period,List<SellPointCategoryConfiguration> datas) async {
    var parsedData = [];
    for (SellPointCategoryConfiguration data in datas) {
      parsedData.add({
        "sell_point_id": data.sellPointId,
        "period_id": data.periodId,
        "category_id": data.categoryId,
        "status_code":data.statusCode,
        "status_id":data.statusId,
        "annotations":data.annotations
      });
    }
    var parameters = {"period_id":period,"sell_point_category_configurations": parsedData};
    await responseSimple(Constants.API_REQUEST_SELLPOINT_CATEGORY_CONFIGURATION_UPLOAD_V2, parameters);
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return SellPointCategoryConfiguration(
        sellPointId: int.parse(json["sell_point_id"].toString()),
        periodId: int.parse(json["period_id"].toString()),
        categoryId: int.parse(json["category_id"]),
        categoryName: json["category_name"].toString(),
        statusId: int.parse(json["status_id"].toString()),
        statusCode: json["status_code"].toString(),
        statusName: json["status_name"].toString()
      );
  }
}
