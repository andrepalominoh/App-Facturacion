import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Deliverie extends BaseModel {
  int id;
  int type_group_id;
  String code;
  String name;
  String type_group_name;
  String type_group_code;

  Deliverie(
      {required this.id,
        required this.name,
        required this.type_group_id,
        required this.code,
        required this.type_group_name,
        required this.type_group_code,
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type_group_id': type_group_id,
      'code': code,
      'type_group_name': type_group_name,
      'type_group_code':type_group_code
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static BaseModel? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Type) return data;
    return null;
  }

  static List<Deliverie> parseModelList(List<BaseModel> data) {
    List<Deliverie> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Deliverie);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }

// static List<Type> parseJson(String data) {
//   List<Type> parsedData = [];
//   try {
//     for (var i = 0; i < data.length; i++) {
//       parsedData.add(data[i] as Type);
//     }
//     // ignore: empty_catches
//   } catch (ex) {}
//   return parsedData;
// }

}
