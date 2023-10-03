import 'package:lya_encuestas/classes/database/models/channel_category.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';
import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/assets/constants.dart';

class ChannelCategoryService extends APIService {
  Future<List<ChannelCategory>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<ChannelCategory> result = ChannelCategory.parseModelList(await responseToModelList(
        Constants.API_REQUEST_CHANNEL_CATEGORY_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return ChannelCategory(
        channelId: int.parse(json["channel_id"].toString()),
        categoryId: int.parse(json["category_id"].toString())
    );
  }
}