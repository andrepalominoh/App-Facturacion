import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';
import 'package:lya_encuestas/widgets/search_data.dart';
import 'package:lya_encuestas/widgets/pickers/district_picker/district_picker_item.dart';
import 'package:lya_encuestas/widgets/pickers/district_picker/district_picker_provider.dart';
import 'package:provider/provider.dart';

class DistrictPicker extends StatefulWidget {
  final bool isMultiSelection;
  final List<District> districts;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DistrictPicker({
    this.isMultiSelection = false,
    this.districts = const [],
  });

  @override
  _DistrictPickerState createState() {
    return _DistrictPickerState();
  }
}

class _DistrictPickerState extends State<DistrictPicker> {
  String text = '';
  List<District> selectedDistricts = [];

  @override
  void initState() {
    super.initState();

    selectedDistricts = widget.districts;
  }

  static int ascendingSort(District c1, District c2) =>
      c1.name.compareTo(c2.name);

  bool containsSearchText(District district) {
    final name = district.name;
    final textLower = text.toLowerCase();
    final districtLower = name.toLowerCase();

    return districtLower.contains(textLower);
  }

  List<District> getPrioritizedDistricts(List<District> districts) {
    final notSelectedDistricts = List.of(districts)
      ..removeWhere((district) => selectedDistricts.contains(district));

    return [
      ...List.of(selectedDistricts)..sort(ascendingSort),
      ...notSelectedDistricts,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DistrictPickerProvider>(context);
    final allDistricts = getPrioritizedDistricts(provider.districts);
    final districts = allDistricts.where(containsSearchText).toList();
    final label = widget.isMultiSelection ? 'Distritos' : 'Distrito';

    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar $label'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SearchData(
            text: text,
            onChanged: (text) => setState(() => this.text = text),
            hintText: 'Buscar $label',
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: districts.map((district) {
                final isSelected = selectedDistricts.contains(district);
                return DistrictPickerItem(
                  district: district,
                  isSelected: isSelected,
                  onSelectedDistrict: selectDistrict,
                );
              }).toList(),
            ),
          ),
          buildSelectButton(context),
        ],
      ),
    );
  }

  Widget buildSelectButton(BuildContext context) {
    final label = widget.isMultiSelection
        ? 'Seleccionar ${selectedDistricts.length} Distritos'
        : 'Continuar';

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Constants.COLOR_PRIMARY, // <-- Red color provided to below Row
        child: Column(children: [
          CustomButton(onPressed: submit, title: label),
        ]));
  }

  void selectDistrict(District district) {
    if (widget.isMultiSelection) {
      final isSelected = selectedDistricts.contains(district);
      setState(() => isSelected
          ? selectedDistricts.remove(district)
          : selectedDistricts.add(district));
    } else {
      Navigator.pop(context, district);
    }
  }

  void submit() {
    if (widget.isMultiSelection) {
      Navigator.pop(context, selectedDistricts);
    } else {
      Navigator.pop(context, null);
    }
  }
}
