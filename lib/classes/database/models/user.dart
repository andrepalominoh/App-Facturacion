import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class User extends BaseModel {
  int id;
  String firstName;
  String lastName;
  String email;
  String token;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'token': token,
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  static User? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is User) return data;
    return null;
  }

  static List<User> parseModelList(List<BaseModel> data) {
    List<User> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as User);
      }
      // ignore: empty_catches
    } catch (ex) {}
    return parsedData;
  }
}
