import 'dart:convert';
import 'package:http/http.dart';
import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/data_access/user_da.dart';
import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/classes/http/api_response.dart';
import 'package:lya_encuestas/assets/constants.dart';

abstract class APIService {
  Future<APIResponse?> getResponse(
      String service, Map<String, Object> parameters, int responseType) async {
    User? user = await UserDA().getLogued();
    Map<String, String> headers;
    if (user != null) {
      String token = user.token;
      headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    } else {
      headers = {
        "Accept": "application/json",
        "Content-Type": "application/json",
      };
    }
    Response res = await post(Uri.parse(Constants.API_URL + service),
        headers: headers,
        body: jsonEncode(parameters),
        encoding: Encoding.getByName("utf-8"));

    if (res.statusCode == 200) {
      return APIResponse.fromJson(
          jsonDecode(res.body), responseType, service, parameters);
    } else {
      return null;
    }
  }

  Future<BaseModel?> responseToModelObject(
      String service, Map<String, Object> parameters) async {
    APIResponse? response = await getResponse(
        service, parameters, APIResponse.RESPONSE_TYPE_OBJECT);

    if (response != null) {
      return parseEntityFromJSON(response.responseObject);
    }
    return null;
  }

  Future<List<BaseModel>> responseToModelList(
      String service, Map<String, Object> parameters) async {
    APIResponse? response =
        await getResponse(service, parameters, APIResponse.RESPONSE_TYPE_LIST);
    
    List<BaseModel> result = [];
    if (response != null) {
      List<dynamic> data = response.responseList;
      for (var i = 0; i < data.length; i++) {
        result.add(parseEntityFromJSON(data[i]));
      }
    }
    return result;
  }

  Future<APIResponse?> responseSimple(
      String service, Map<String, Object> parameters) async {
    APIResponse? response = await getResponse(
        service, parameters, APIResponse.RESPONSE_TYPE_SIMPLE);
    return response;
  }

  BaseModel parseEntityFromJSON(Map<String, dynamic> json);
}
