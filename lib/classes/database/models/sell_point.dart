import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class SellPoint extends BaseModel {
  int id;
  int referenceSellPointId;
  int channelId;
  int districtId;
  String name;
  String address;
  String? contactName;
  String? contactPhone;
  String? annotations;

  SellPoint(
      {required this.id,
      required this.referenceSellPointId,
      required this.channelId,
      required this.districtId,
      required this.name,
      required this.address,
      this.contactName,
      this.contactPhone,
      this.annotations
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference_sell_point_id': referenceSellPointId,
      'channel_id': channelId,
      'district_id': districtId,
      'name': name,
      'address': address,
      'contact_name': contactName,
      'contact_phone': contactPhone,
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

  static SellPoint? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is SellPoint) return data;
    return null;
  }

  static List<SellPoint> parseModelList(List<BaseModel> data) {
    List<SellPoint> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as SellPoint);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
