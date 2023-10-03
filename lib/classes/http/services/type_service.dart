import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/type.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class TypeService extends APIService {
  Future<List<Type>> list() async {
    var parameters = {"type_group_code": "MDP"};
    List<Type> result = Type.parseModelList(await responseToModelList(
        Constants.API_REQUEST_GET_PAYMENT_APP, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Type(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        type_group_id: json['type_group_id'],
        type_group_code: json['type_group_code'],
        type_group_name: json['type_group_name']
    );
  }
}
