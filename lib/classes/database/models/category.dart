import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Category extends BaseModel {
  int id;
  String code;
  String name;

  Category({
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

  static Category? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Category) return data;
    return null;
  }

  static List<Category> parseModelList(List<BaseModel> data) {
    List<Category> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Category);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
