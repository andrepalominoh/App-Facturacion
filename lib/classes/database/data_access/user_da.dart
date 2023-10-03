import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/data_access/answer_da.dart';
import 'package:lya_encuestas/classes/database/data_access/category_da.dart';
import 'package:lya_encuestas/classes/database/data_access/channel_category_da.dart';
import 'package:lya_encuestas/classes/database/data_access/channel_da.dart';
import 'package:lya_encuestas/classes/database/data_access/district_da.dart';
import 'package:lya_encuestas/classes/database/data_access/period_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sell_point_category_configuration_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sell_point_da.dart';
import 'package:lya_encuestas/classes/database/data_access/sku_da.dart';
import 'package:lya_encuestas/classes/database/data_access/synchronization_da.dart';
import 'package:lya_encuestas/classes/database/data_access/last_answer_da.dart';
import 'package:lya_encuestas/classes/database/models/user.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';

class UserDA extends BaseDA {
  Future<User?> getLogued() async {
    final List<User> data = User.parseModelList(await list(null, null));
    if (data.length == 1) return data[0];
    return null;
  }

  Future<void> deleteAllBase(bool includeUser) async {
    if (includeUser) {
      UserDA().delete(null);
      PeriodDA().delete(null);
    }
    CategoryDA().delete(null);
    ChannelDA().delete(null);
    SellPointDA().delete(null);
    DistrictDA().delete(null);
    SkuDA().delete(null);
    LastAnswerDA().delete(null);
    AnswerDA().delete(null);
    SellPointCategoryConfigurationDA().delete(null);
    ChannelCategoryDA().delete(null);
    SynchronizationDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_USERS;
  }

  @override
  User fillModelData(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      firstName: data['first_name'],
      lastName: data['last_name'],
      email: data['email'],
      token: data['token'],
    );
  }
}
