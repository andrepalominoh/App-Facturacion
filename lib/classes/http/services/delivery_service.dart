import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/models/delivery.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class DeliveryService extends APIService {

  Future<List<Delivery>> list(String date,int transportId,int clientId,String numRequest) async {
    var parameters={
      "date": date,
      "id_transport":transportId
    };
    if(clientId!=0){
      parameters={
        "date": date,
        "id_transport":transportId,
        "id_client":clientId
      };
    }
    if(numRequest!=''){
      parameters={
        "date": date,
        "id_transport":transportId,
        "num_request":numRequest
      };
    }
    List<Delivery> result = Delivery.parseModelList(await responseToModelList(
        Constants.API_REQUEST_POST_DELIVERY_GET, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Delivery(
      id: int.parse(json["id"].toString()),
      code_transaction:json['code_transaction'],
      mount:json['mount'],
      code_pos:json['code_pos'],
      date_id:json['date_id'],
      client_id:json['client_id'],
      transport_id:json['transport_id'],
      type_payment_id:json['type_payment_id'],
      type_code:json['type_code'],
      type_name:json['type_name'],
      client_name:json['client_name'],
      client_lastname:json['client_lastname'],
      num_request:json['num_request'],
      client_code:json['client_code'],
      client_status_type_id:json['client_status_type_id'],
      client_type_document_identity:json['client_type_document_identity'],
      client_identity_document:json['client_identity_document'],
      carriers_code:json['carriers_code'],
      carriers_name:json['carriers_name'],
      carriers_lastname:json['carriers_lastname'],
      carriers_identity_document:json['carriers_identity_document'],
      presettlement_id:json['presettlement_id'],
      presettlement_type_code:json['presettlement_type_code'],
      presettlement_mount:json['presettlement_mount'],
    );
  }
}
