import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Client extends BaseModel {
  int id;
  String name;
  String lastname;
  String fullname;

  Client({
    required this.id,
    required this.name,
    required this.lastname,
    required this.fullname,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'fullname':fullname,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static Client? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Client) return data;
    return null;
  }

  static List<Client> parseModelList(List<BaseModel> data) {
    List<Client> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Client);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
