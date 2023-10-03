import 'dart:convert';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Customer extends BaseModel {
  int id;
  String name;
  String lastname;
  String phone;
  String code;
  String address;
  String district;
  int type_document_identity;
  String number_document;
  String type_document_name;
  String type_document_code;


  Customer(
      {required this.id,
        required this.name,
        required this.lastname,
        required this.phone,
        required this.code,
        required this.address,
        required this.district,
        required this.type_document_identity,
        required this.number_document,
        required this.type_document_name,
        required this.type_document_code
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name':name,
      'lastname':lastname,
      'phone':phone,
      'code':code,
      'address':address,
      'district':district,
      'type_document_identity':type_document_identity,
      'number_document':number_document,
      'type_document_name':type_document_name,
      'type_document_code':type_document_code
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static Customer? parseModelObject(Customer? data) {
    if (data == null) return null;
    if (data is Type) return data;
    return null;
  }

  static List<Customer> parseModelList(List<BaseModel> data) {
    List<Customer> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Customer);
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
