import 'package:lya_encuestas/assets/constants.dart';

class APIResponse {
  final String status;
  final String message;
  final String responseSimple;
  final Map<String, dynamic> responseObject;
  final List<dynamic> responseList;

  static const int RESPONSE_TYPE_SIMPLE = 1;
  static const int RESPONSE_TYPE_OBJECT = 2;
  static const int RESPONSE_TYPE_LIST = 3;

  APIResponse({
    required this.status,
    required this.message,
    required this.responseSimple,
    required this.responseObject,
    required this.responseList,
  });

  factory APIResponse.fromJson(Map<String, dynamic> json, int responseType,
      String service, Map<String, Object> parameters) {
    return APIResponse(
        status: json[Constants.API_RESPONSE_STATUS_KEY] as String,
        message: json[Constants.API_RESPONSE_MESSAGE_KEY] as String,
        responseSimple: (responseType == RESPONSE_TYPE_SIMPLE
            ? json[Constants.API_RESPONSE_RESPONSE_KEY] as String
            : ""),
        responseObject: (responseType == RESPONSE_TYPE_OBJECT
            ? json[Constants.API_RESPONSE_RESPONSE_KEY] as Map<String, dynamic>
            : <String, dynamic>{}),
        responseList: (responseType == RESPONSE_TYPE_LIST
            ? json[Constants.API_RESPONSE_RESPONSE_KEY] as List<dynamic>
            : []));
  }
}
