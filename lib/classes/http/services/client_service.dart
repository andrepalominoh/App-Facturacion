import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/client.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class ClientService extends APIService {
  Future<List<Client>> list(String dates, int transportId) async {
    var parameters = {
      "dates": dates,
      "id_transport": transportId
    };
    List<Client> result = Client.parseModelList(await responseToModelList(
        Constants.API_REQUEST_POST_PRESETTLEMENT_CLIENT, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Client(
        id: int.parse(json["id"].toString()),
        name: json['name'].toString(),
        lastname:  json['lastname'].toString(),
        fullname: json['fullname'].toString()
    );
  }
}

