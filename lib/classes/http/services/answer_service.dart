import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/answer.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class AnswerService extends APIService {
  Future<List<Answer>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<Answer> result = Answer.parseModelList(await responseToModelList(
        Constants.API_REQUEST_ANSWER_LIST, parameters));
    return result;
  }

  Future<void> upload(int syncId, List<Answer> data) async {
    var parsedData = [];
    for (var i = 0; i < data.length; i++) {
      parsedData.add({
        "temp_id": data[i].id,
        "sell_point_id": data[i].sellPointId,
        "period_id": data[i].periodId,
        "sku_id": data[i].skuId,
        "survey_id": data[i].surveyId,
        "purchase": data[i].purchase,
        "closed_inventory": data[i].closedInventory,
        "open_inventory": data[i].openInventory,
        "price": data[i].price,
        "estimated_sale": data[i].estimatedSale,
      });
    }
    var parameters = {"synchronization_id": syncId, "answers": parsedData};
    await responseSimple(Constants.API_REQUEST_ANSWERS_UPLOAD, parameters);
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Answer(
        id: int.parse(json["answer_id"].toString()),
        periodId: int.parse(json["period_id"].toString()),
        sellPointId: int.parse(json["sell_point_id"].toString()),
        skuId: int.parse(json["sku_id"].toString()),
        surveyId: int.parse(json["survey_id"].toString()),
        price: json["price"] ?? "",
        closedInventory: json["closed_inventory"] ?? "",
        openInventory: json["open_inventory"] ?? "",
        purchase: json["purchase"] ?? "",
        estimatedSale: json["estimated_sale"] ?? "",
        syncPollsterFirstName: json["sync_pollster_first_name"],
        syncPollsterLastName: json["sync_pollster_last_name"],
        syncPollsterEmail: json["sync_pollster_email"],
        syncRequestDate: json["sync_request_date"]);
  }
}
