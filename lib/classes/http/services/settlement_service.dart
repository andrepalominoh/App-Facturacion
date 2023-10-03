import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/models/settlement.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class SettlementService extends APIService {

  Future<List<Settlement>> list(String date,int transport_id) async {
    var parameters={
        "date": date,
        "transport_id":transport_id};
    List<Settlement> result = Settlement.parseModelList(await responseToModelList(
        Constants.API_REQUEST_POST_SETTLEMENT_GET, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Settlement(
        id: int.parse(json["id"].toString()),
        date_id: json["date_id"],
        transport_id: json["transport_id"],
        photo : json['photo'],
        mount: json['mount'],
        code_transaction: json['code_transaction']
    );
  }
}
