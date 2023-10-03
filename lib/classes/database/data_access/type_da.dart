import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/classes/database/models/type.dart';

class TypeDA extends BaseDA {
  // Future<void> deleteAllBase() async {
  //   TypeDA().delete(null);
  // }

  @override
  String getTable() {
    return Constants.DB_TABLE_TYPES;
  }

  @override
  Type fillModelData(Map<String, dynamic> data) {
    return Type(
      id: data['id'],
      name: data['name'],
      code: data['code'],
      type_group_id: data['type_group_id'],
      type_group_code: data['type_group_code'],
      type_group_name: data['type_group_name'],
    );
  }


}
