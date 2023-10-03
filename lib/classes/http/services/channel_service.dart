import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class ChannelService extends APIService {
  Future<List<Channel>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<Channel> result = Channel.parseModelList(await responseToModelList(
        Constants.API_REQUEST_CHANNEL_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Channel(
        id: int.parse(json["channel_id"].toString()),
        code: json["code"],
        name: json["name"]);
  }
}
