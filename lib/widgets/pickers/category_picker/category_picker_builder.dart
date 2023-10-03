import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/classes/database/models/sell_point.dart';
import 'package:lya_encuestas/widgets/pickers/category_picker/category_picker.dart';
import 'package:lya_encuestas/widgets/pickers/category_picker/category_picker_provider.dart';
import 'package:provider/provider.dart';

class CategoryPickerBuilder {
  static Widget build(context, Category? selCategory,SellPoint? sellPoint, setState) {
    Category? returnCategory;
    Future<void> onTap() async {
      final provider = Provider.of<CategoryPickerProvider>(context, listen: false);
      provider.reloadCategories(sellPoint);
      returnCategory = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CategoryPicker()));
      if (returnCategory == null) return;
      setState(returnCategory);
    }

    return CategoryPickerBuilder.buildCategoryPicker(
      child: selCategory == null
          ? CategoryPickerBuilder.buildListTile(
              title: 'Seleccione', onTap: onTap)
          : CategoryPickerBuilder.buildListTile(
              title: selCategory.name,
              onTap: onTap,
            ),
    );
  }

  static Widget buildListTile({
    required String title,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_drop_down, color: Colors.black),
    );
  }

  static Widget buildCategoryPicker({
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
