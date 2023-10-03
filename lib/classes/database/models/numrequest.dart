import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class NumRequest extends BaseModel {
  String num_request;

  NumRequest({
    required this.num_request
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'num_request': num_request
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static NumRequest? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is NumRequest) return data;
    return null;
  }

  static List<NumRequest> parseModelList(List<BaseModel> data) {
    List<NumRequest> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as NumRequest);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
