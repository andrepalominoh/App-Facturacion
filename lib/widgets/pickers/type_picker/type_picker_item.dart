import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/type.dart';

class TypePickerItem extends StatelessWidget {
  final Type type;
  final bool isSelected;
  // final ValueChanged<Type> onSelectedDistrict;

  TypePickerItem({
    required this.type,
    required this.isSelected,
    // required this.onSelectedDistrict,
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
      // onTap: () => onSelectedDistrict(type),
      leading: const Icon(Icons.location_on_outlined,
          color: Constants.COLOR_SECONDARY),
      title: Text(
        type.name.toString(),
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
