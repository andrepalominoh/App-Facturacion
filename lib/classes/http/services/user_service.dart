import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class UserService extends APIService {
  Future<User?> makeLogin(String user, String password) async {
    var parameters = {
      "email": user,
      "password": password,
      "device_name": "mobile_prueba",
    };
    User? result = User.parseModelObject(await responseToModelObject(
        Constants.API_REQUEST_USER_LOGIN, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return User(
        id: json["user"]["user_id"],
        email: json["user"]["email"],
        firstName: json["user"]["name"],
        lastName: json["user"]["last_name"],
        token: json["token"]);
  }
}
