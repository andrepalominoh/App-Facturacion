import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class DistrictService extends APIService {
  Future<List<District>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<District> result = District.parseModelList(await responseToModelList(
        Constants.API_REQUEST_DISTRICT_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return District(
        id: int.parse(json["district_id"].toString()),
        ubigeo: json["ubigeo"],
        name: json["name"]);
  }
}
