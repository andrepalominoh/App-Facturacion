import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';

class CategoryPickerItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final ValueChanged<Category> onSelectedCategory;

  CategoryPickerItem({
    required this.category,
    required this.isSelected,
    required this.onSelectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).primaryColor;
    final style = isSelected
        ? TextStyle(
            fontSize: 18,
            color: selectedColor,
            fontWeight: FontWeight.bold,
          )
        : const TextStyle(fontSize: 18);

    return ListTile(
      onTap: () => onSelectedCategory(category),
      leading: const Icon(Icons.location_on_outlined,
          color: Constants.COLOR_SECONDARY),
      title: Text(
        category.name,
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
