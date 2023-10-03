import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/client.dart';
import 'package:lya_encuestas/classes/database/models/numrequest.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class NumRequestService extends APIService {
  Future<List<NumRequest>> list(String dates, int transportId) async {
    var parameters = {
      "dates": dates,
      "id_transport": transportId
    };
    List<NumRequest> result = NumRequest.parseModelList(await responseToModelList(
        Constants.API_REQUEST_POST_DELIVERY_NUMREQUEST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return NumRequest(
      num_request: json['num_request'],
    );
  }
}