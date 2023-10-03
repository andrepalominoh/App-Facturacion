import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/channel_category.dart';

class ChannelCategoryDA extends BaseDA {

  Future<void> deleteAllBase() async {
    ChannelCategoryDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_CHANNEL_CATEGORY;
  }

   @override
  ChannelCategory fillModelData(Map<String, dynamic> data) {
    return ChannelCategory(
      channelId: data['channel_id'],
      categoryId: data['category_id']
    );
  }
}