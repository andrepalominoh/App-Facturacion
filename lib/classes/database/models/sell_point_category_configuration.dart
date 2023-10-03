import 'dart:convert';
import 'package:lya_encuestas/classes/database/base_model.dart';

class SellPointCategoryConfiguration extends BaseModel {
  int? sellPointId;
  int? periodId;
  int? categoryId;
  String? categoryName;
  int? statusId;
  String? statusCode;
  String? statusName;
  String? annotations;

  SellPointCategoryConfiguration(
      {this.sellPointId,
      this.periodId,
      this.categoryId,
      this.categoryName,
      this.statusId,
      this.statusName,
      this.statusCode,
      this.annotations
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'sell_point_id': sellPointId,
      'period_id': periodId,
      'category_id': categoryId,
      'category_name':categoryName,
      'status_id': statusId,
      'status_code':statusCode,
      'status_name':statusName,
      'annotations': annotations
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static SellPointCategoryConfiguration? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is SellPointCategoryConfiguration) return data;
    return null;
  }

  static List<SellPointCategoryConfiguration> parseModelList(List<BaseModel> data) {
    List<SellPointCategoryConfiguration> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as SellPointCategoryConfiguration);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
