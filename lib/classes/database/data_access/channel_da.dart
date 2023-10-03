import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/channel.dart';

class ChannelDA extends BaseDA {
  Future<void> deleteAllBase() async {
    ChannelDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_CHANNELS;
  }

  @override
  Channel fillModelData(Map<String, dynamic> data) {
    return Channel(
      id: data['id'],
      code: data['code'],
      name: data['name'],
    );
  }
}
