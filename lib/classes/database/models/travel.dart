import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Travel extends BaseModel {
  int id;
  String name;

  Travel(
      {required this.id,
        required this.name,
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Travel? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Travel) return data;
    return null;
  }

  static List<Travel> parseModelList(List<BaseModel> data) {
    List<Travel> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Travel);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
