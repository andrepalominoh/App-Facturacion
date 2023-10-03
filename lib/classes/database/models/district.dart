import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class District extends BaseModel {
  int id;
  String ubigeo;
  String name;

  District({
    required this.id,
    required this.ubigeo,
    required this.name,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ubigeo': ubigeo,
      'name': name,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static District? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is District) return data;
    return null;
  }

  static List<District> parseModelList(List<BaseModel> data) {
    List<District> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as District);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
