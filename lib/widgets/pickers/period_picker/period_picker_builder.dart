import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/widgets/pickers/period_picker/period_picker.dart';
import 'package:lya_encuestas/widgets/pickers/period_picker/period_picker_provider.dart';
import 'package:provider/provider.dart';

class PeriodPickerBuilder {
  static Widget build(context, Period? selPeriod, setState) {
    Period? returnPeriod;
    Future<void> onTap() async {
      final provider =
          Provider.of<PeriodPickerProvider>(context, listen: false);
      provider.reloadPeriods();
      returnPeriod = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => PeriodPicker()));
      if (returnPeriod == null) return;
      setState(returnPeriod);
    }

    return PeriodPickerBuilder.buildPeriodPicker(
      child: selPeriod == null
          ? PeriodPickerBuilder.buildListTile(title: 'Seleccione', onTap: onTap)
          : PeriodPickerBuilder.buildListTile(
              title: selPeriod.year + " - " + selPeriod.month,
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

  static Widget buildPeriodPicker({
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
