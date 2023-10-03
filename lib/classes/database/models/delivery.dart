import 'dart:convert';
import 'dart:ffi';

import 'package:lya_encuestas/classes/database/base_model.dart';

class Delivery extends BaseModel {
  int id;
  String? code_transaction;
  String mount;
  String? code_pos;
  int date_id;
  int client_id;
  int transport_id;
  int? type_payment_id;
  String? type_code;
  String? type_name;
  String num_request;
  String client_name;
  String client_lastname;
  String client_code;
  int client_status_type_id;
  int client_type_document_identity;
  String client_identity_document;
  String carriers_code;
  String carriers_name;
  String carriers_lastname;
  String carriers_identity_document;
  String presettlement_id;
  String presettlement_type_code;
  String presettlement_mount;

  Delivery(
      {required this.id,
        this.code_transaction,
        required this.mount,
        this.code_pos,
        required this.date_id,
        required this.client_id,
        required this.transport_id,
        this.type_payment_id,
        this.type_code,
        this.type_name,
        required this.num_request,
        required this.client_name,
        required this.client_lastname,
        required this.client_code,
        required this.client_status_type_id,
        required this.client_type_document_identity,
        required this.client_identity_document,
        required this.carriers_code,
        required this.carriers_name,
        required this.carriers_lastname,
        required this.carriers_identity_document,
        required this.presettlement_id,
        required this.presettlement_type_code,
        required this.presettlement_mount
      });

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code_transaction':code_transaction,
      'mount':mount,
      'code_pos':code_pos,
      'date_id':date_id,
      'client_id':client_id,
      'transport_id':transport_id,
      'type_payment_id':type_payment_id,
      'type_code':type_code,
      'type_name':type_name,
      'num_request':num_request,
      'client_name':client_name,
      'client_lastname':client_lastname,
      'client_code':client_code,
      'client_status_type_id':client_status_type_id,
      'client_type_document_identity':client_type_document_identity,
      'client_identity_document':client_identity_document,
      'carriers_code':carriers_code,
      'carriers_name':carriers_name,
      'carriers_lastname':carriers_lastname,
      'carriers_identity_document':carriers_identity_document,
      'presettlement_id':presettlement_id,
      'presettlement_type_code':presettlement_type_code,
      'presettlement_mount':presettlement_mount
    };
  }

  @override
  String toString() {
    return jsonEncode(toMap());
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  static BaseModel? parseModelObject(BaseModel? data) {
    if (data == null) return null;
    if (data is Delivery) return data;
    return null;
  }

  static List<Delivery> parseModelList(List<BaseModel> data) {
    List<Delivery> parsedData = [];
    try {
      for (var i = 0; i < data.length; i++) {
        parsedData.add(data[i] as Delivery);
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
