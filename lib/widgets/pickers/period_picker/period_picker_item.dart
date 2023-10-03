import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';

class PeriodPickerItem extends StatelessWidget {
  final Period period;
  final bool isSelected;
  final ValueChanged<Period> onSelectedPeriod;

  PeriodPickerItem({
    required this.period,
    required this.isSelected,
    required this.onSelectedPeriod,
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
      onTap: () => onSelectedPeriod(period),
      leading: const Icon(Icons.location_on_outlined,
          color: Constants.COLOR_SECONDARY),
      title: Text(
        period.year + " - " + period.month,
        style: style,
      ),
      trailing:
          isSelected ? Icon(Icons.check, color: selectedColor, size: 26) : null,
    );
  }
}
