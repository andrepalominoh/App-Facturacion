import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/last_answer.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class LastAnswerService extends APIService {
  Future<List<LastAnswer>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<LastAnswer> result = LastAnswer.parseModelList(
        await responseToModelList(
            Constants.API_REQUEST_LAST_ANSWER_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return LastAnswer(
      workOrderId: int.parse(json["work_order_id"].toString()),
      workOrderCode: json["work_order_code"],
      frecuencyTypeCode: json["frecuency_type_code"],
      frecuencyTypeName: json["frecuency_type_name"],
      surveyId: int.parse(json["survey_id"].toString()),
      surveyTypeCode: json["survey_type_code"],
      surveyTypeName: json["survey_type_name"],
      periodCode: json["period_code"],
      periodName: json["period_name"],
      categoryId: int.parse(json["category_id"].toString()),
      surveyConfigTypeId: int.parse(json["survey_config_type_id"].toString()),
      surveyConfigTypeCode: json["survey_config_type_code"],
      surveyConfigTypeName: json["survey_config_type_name"],
      sellPointId: int.parse(json["sell_point_id"].toString()),
      skuId: int.parse(json["sku_id"].toString()),
      answers: json["answers"],
    );
  }
}
