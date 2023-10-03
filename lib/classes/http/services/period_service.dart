import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class PeriodService extends APIService {
  Future<List<Period>> list() async {
    var parameters = {"-": "-"};
    List<Period> result = Period.parseModelList(await responseToModelList(
        Constants.API_REQUEST_PERIOD_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Period(
        id: int.parse(json["period_id"].toString()),
        code: json["code"],
        month: json["month"],
        year: json["year"]);
  }
}
