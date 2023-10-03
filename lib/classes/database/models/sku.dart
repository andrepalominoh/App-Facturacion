import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Sku extends BaseModel {
  int id;
  int referenceSkuId;
  int categoryId;
  String name;
  int isPrioritized;
  String? annotations;

  Sku({
    required this.id,
    required this.referenceSkuId,
    required this.categoryId,
    required this.name,
    required this.isPrioritized,
    this.annotations,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference_sku_id': referenceSkuId,
      'category_id': categoryId,
      'name': name,
      'is_prioritized': isPrioritized,
      'annotations': annotations,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Sku? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Sku) return data;
    return null;
  }

  static List<Sku> parseModelList(List<BaseModel> data) {
    List<Sku> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Sku);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
