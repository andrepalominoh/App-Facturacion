import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/widgets/pickers/district_picker/district_picker.dart';
import 'package:lya_encuestas/widgets/pickers/district_picker/district_picker_provider.dart';
import 'package:provider/provider.dart';

class DistrictPickerBuilder {
  static Widget build(context, District? selDistrict, setState) {
    District? returnDistrict;
    Future<void> onTap() async {
      final provider =
          Provider.of<DistrictPickerProvider>(context, listen: false);
      provider.reloadDistricts();
      returnDistrict = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => DistrictPicker()));
      if (returnDistrict == null) return;
      setState(returnDistrict);
    }

    return DistrictPickerBuilder.buildDistrictPicker(
      child: selDistrict == null
          ? DistrictPickerBuilder.buildListTile(
              title: 'Seleccione', onTap: onTap)
          : DistrictPickerBuilder.buildListTile(
              title: selDistrict.name,
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

  static Widget buildDistrictPicker({
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
