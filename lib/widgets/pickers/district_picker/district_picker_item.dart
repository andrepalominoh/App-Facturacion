import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';

class DistrictPickerItem extends StatelessWidget {
  final District district;
  final bool isSelected;
  final ValueChanged<District> onSelectedDistrict;

  DistrictPickerItem({
    required this.district,
    required this.isSelected,
    required this.onSelectedDistrict,
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
      onTap: () => onSelectedDistrict(district),
      leading: const Icon(Icons.location_on_outlined,
          color: Constants.COLOR_SECONDARY),
      title: Text(
        district.name,
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
