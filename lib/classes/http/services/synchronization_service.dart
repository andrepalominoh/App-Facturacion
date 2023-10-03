import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/synchronization.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class SynchronizationService extends APIService {
  Future<Synchronization?> get(int pollsterUserId) async {
    var parameters = {"pollster_user_id": pollsterUserId.toString()};
    Synchronization? result = Synchronization.parseModelObject(
        await responseToModelObject(
            Constants.API_REQUEST_SYNCRHONIZATION_GET, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Synchronization(
        id: int.parse(json["synchronization_id"].toString()),
        requestDate: json["request_date"]);
  }
}
