import 'package:flutter/material.dart';
import 'package:lya_encuestas/classes/database/models/travel.dart';
import 'package:lya_encuestas/classes/database/models/type.dart';
import 'package:lya_encuestas/widgets/pickers/type_picker/type_picker.dart';
import 'package:lya_encuestas/widgets/pickers/type_picker/type_picker_provider.dart';
import 'package:provider/provider.dart';

class TypePickerBuilder {
  static Widget build(context, Type? selType, setState) {
    Type? returnDistrict;
    Future<void> onTap() async {
      final provider =
      Provider.of<TypePickerProvider>(context, listen: false);
      provider.reloadTypes();
      returnDistrict = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => TypePicker()));
      if (returnDistrict == null) return;
      setState(returnDistrict);
    }

    return TypePickerBuilder.buildTypePaymentPicker(
      child: selType == null
          ? TypePickerBuilder.buildListTile(
          title: 'Seleccione', onTap: onTap)
          : TypePickerBuilder.buildListTile(
        title: selType.name,
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

  static Widget buildTypePaymentPicker({
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(margin: EdgeInsets.zero, child: child),
        ],
      );
}
