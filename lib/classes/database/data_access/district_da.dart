import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';

class DistrictDA extends BaseDA {
  Future<void> deleteAllBase() async {
    DistrictDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_DISTRICTS;
  }

  @override
  District fillModelData(Map<String, dynamic> data) {
    return District(
      id: data['id'],
      ubigeo: data['ubigeo'],
      name: data['name'],
    );
  }
}
