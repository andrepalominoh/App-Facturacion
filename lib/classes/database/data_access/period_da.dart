import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';

class PeriodDA extends BaseDA {
  Future<void> deleteAllBase() async {
    PeriodDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_PERIODS;
  }

  @override
  Period fillModelData(Map<String, dynamic> data) {
    return Period(
      id: data['id'],
      code: data['code'],
      month: data['month'],
      year: data['year'],
    );
  }
}
