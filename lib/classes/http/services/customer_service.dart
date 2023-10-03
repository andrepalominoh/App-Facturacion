import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/customer.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class CustomerService extends APIService {
  Future<List<Customer>> list() async {
    var parameters = {"type_group_code": "MDP"};
    List<Customer> result = Customer.parseModelList(await responseToModelList(
        Constants.API_REQUEST_GET_CUSTOMER, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Customer(
        id:json['id'],
        name: json['name'],
        lastname: json["lastname"],
        phone: json["phone"],
        code: json["code"],
        address: json["address"],
        district: json["district"],
        type_document_identity: json["type_document_identity"],
        number_document: json["number_document"],
        type_document_name: json["type_document_name"],
        type_document_code: json["type_document_code"]
    );
  }
}