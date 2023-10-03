import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';
import 'package:lya_encuestas/widgets/search_data.dart';
import 'package:lya_encuestas/widgets/pickers/period_picker/period_picker_item.dart';
import 'package:lya_encuestas/widgets/pickers/period_picker/period_picker_provider.dart';
import 'package:provider/provider.dart';

class PeriodPicker extends StatefulWidget {
  final bool isMultiSelection;
  final List<Period> periods;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  PeriodPicker({
    this.isMultiSelection = false,
    this.periods = const [],
  });

  @override
  _PeriodPickerState createState() {
    return _PeriodPickerState();
  }
}

class _PeriodPickerState extends State<PeriodPicker> {
  String text = '';
  List<Period> selectedPeriods = [];

  @override
  void initState() {
    super.initState();

    selectedPeriods = widget.periods;
  }

  static int ascendingSort(Period c1, Period c2) => c1.code.compareTo(c2.code);

  bool containsSearchText(Period period) {
    final name = period.code;
    final textLower = text.toLowerCase();
    final periodLower = name.toLowerCase();

    return periodLower.contains(textLower);
  }

  List<Period> getPrioritizedPeriods(List<Period> periods) {
    final notSelectedPeriods = List.of(periods)
      ..removeWhere((period) => selectedPeriods.contains(period));

    return [
      ...List.of(selectedPeriods)..sort(ascendingSort),
      ...notSelectedPeriods,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PeriodPickerProvider>(context);
    final allPeriods = getPrioritizedPeriods(provider.periods);
    final periods = allPeriods.where(containsSearchText).toList();
    final label = widget.isMultiSelection ? 'Periodos' : 'Periodo';

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
              children: periods.map((period) {
                final isSelected = selectedPeriods.contains(period);
                return PeriodPickerItem(
                  period: period,
                  isSelected: isSelected,
                  onSelectedPeriod: selectPeriod,
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
        ? 'Seleccionar ${selectedPeriods.length} Periodos'
        : 'Continuar';

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Constants.COLOR_PRIMARY, // <-- Red color provided to below Row
        child: Column(children: [
          CustomButton(onPressed: submit, title: label),
        ]));
  }

  void selectPeriod(Period period) {
    if (widget.isMultiSelection) {
      final isSelected = selectedPeriods.contains(period);
      setState(() => isSelected
          ? selectedPeriods.remove(period)
          : selectedPeriods.add(period));
    } else {
      Navigator.pop(context, period);
    }
  }

  void submit() {
    if (widget.isMultiSelection) {
      Navigator.pop(context, selectedPeriods);
    } else {
      Navigator.pop(context, null);
    }
  }
}
