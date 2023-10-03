import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Channel extends BaseModel {
  int id;
  String code;
  String name;

  Channel({
    required this.id,
    required this.code,
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static Channel? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Channel) return data;
    return null;
  }

  static List<Channel> parseModelList(List<BaseModel> data) {
    List<Channel> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Channel);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
