import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Settlement extends BaseModel {
  int id;
  int date_id;
  int transport_id;
  String photo;
  String mount;
  String code_transaction;

  Settlement(
      {required this.id,
        required this.date_id,
        required this.transport_id,
        required this.photo,
        required this.mount,
        required this.code_transaction,
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date_id': date_id,
      'transport_id': transport_id,
      'photo': photo,
      'mount': mount,
      'code_transaction':code_transaction
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Settlement? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Settlement) return data;
    return null;
  }

  static List<Settlement> parseModelList(List<BaseModel> data) {
    List<Settlement> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Settlement);
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
