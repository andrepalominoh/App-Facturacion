import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';

class CategoryDA extends BaseDA {
  Future<void> deleteAllBase() async {
    CategoryDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_CATEGORIES;
  }

  @override
  Category fillModelData(Map<String, dynamic> data) {
    return Category(
      id: data['id'],
      code: data['code'],
      name: data['name'],
    );
  }
}
