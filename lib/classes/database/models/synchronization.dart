import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Synchronization extends BaseModel {
  int id;
  String requestDate;

  Synchronization({
    required this.id,
    required this.requestDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'request_date': requestDate,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static Synchronization? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Synchronization) return data;
    return null;
  }

  static List<Synchronization> parseModelList(List<BaseModel> data) {
    List<Synchronization> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Synchronization);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
