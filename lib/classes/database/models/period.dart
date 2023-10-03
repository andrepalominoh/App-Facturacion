import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Period extends BaseModel {
  int id;
  String code;
  String month;
  String year;

  Period(
      {required this.id,
      required this.code,
      required this.month,
      required this.year});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'month': month,
      'year': year,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static Period? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Period) return data;
    return null;
  }

  static List<Period> parseModelList(List<BaseModel> data) {
    List<Period> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Period);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
