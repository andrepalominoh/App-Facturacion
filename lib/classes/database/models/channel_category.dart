import 'dart:convert';
import 'package:lya_encuestas/classes/database/base_model.dart';

class ChannelCategory extends BaseModel{
  int channelId;
  int categoryId;

  ChannelCategory({required this.channelId, required this.categoryId});

  @override
  Map<String, dynamic> toMap() {
    return {
      'channel_id': channelId,
      'category_id': categoryId
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static ChannelCategory? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is ChannelCategory) return data;
    return null;
  }

  static List<ChannelCategory> parseModelList(List<BaseModel> data) {
    List<ChannelCategory> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as ChannelCategory);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}