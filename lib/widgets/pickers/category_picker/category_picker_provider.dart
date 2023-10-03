import 'package:flutter/cupertino.dart';
import 'package:lya_encuestas/classes/database/data_access/category_da.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';

class CategoryPickerProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  CategoryPickerProvider(sp) {
    reloadCategories(sp);
  }

  void reloadCategories(SellPoint? sp) {
    loadCategories(sp).then((categories) {
      _categories = categories;
      notifyListeners();
    });
  }

  Future<List<Category>> loadCategories(SellPoint? sp) async {
    final data = Category.parseModelList(await CategoryDA().list((sp==null?' 1=1 ':' id in (select category_id from channel_categories x where x.channel_id=${sp.channelId}) and id not in (select x.category_id from sell_point_category_configurations x where x.sell_point_id=${sp.id} and x.status_code="PV-EXCL")'), null));
    data.sort(ascendingSort);
    print("Recargando categorías");
    return data;
  }

  static int ascendingSort(Category c1, Category c2) =>
      c1.name.compareTo(c2.name);
}
