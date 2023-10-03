import 'package:flutter/material.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/widgets/custom_buttom.dart';
import 'package:lya_encuestas/widgets/search_data.dart';
import 'package:lya_encuestas/widgets/pickers/category_picker/category_picker_item.dart';
import 'package:lya_encuestas/widgets/pickers/category_picker/category_picker_provider.dart';
import 'package:provider/provider.dart';

class CategoryPicker extends StatefulWidget {
  final bool isMultiSelection;
  final List<Category> categories;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  CategoryPicker({
    this.isMultiSelection = false,
    this.categories = const [],
  });

  @override
  _CategoryPickerState createState() {
    return _CategoryPickerState();
  }
}

class _CategoryPickerState extends State<CategoryPicker> {
  String text = '';
  List<Category> selectedCategories = [];

  @override
  void initState() {
    super.initState();

    selectedCategories = widget.categories;
  }

  static int ascendingSort(Category c1, Category c2) =>
      c1.name.compareTo(c2.name);

  bool containsSearchText(Category category) {
    final name = category.name;
    final textLower = text.toLowerCase();
    final categoryLower = name.toLowerCase();

    return categoryLower.contains(textLower);
  }

  List<Category> getPrioritizedCategories(List<Category> categories) {
    final notSelectedCategories = List.of(categories)
      ..removeWhere((category) => selectedCategories.contains(category));

    return [
      ...List.of(selectedCategories)..sort(ascendingSort),
      ...notSelectedCategories,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryPickerProvider>(context);
    final allCategories = getPrioritizedCategories(provider.categories);
    final categories = allCategories.where(containsSearchText).toList();
    final label = widget.isMultiSelection ? 'Categorías' : 'Categoría';

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
              children: categories.map((category) {
                final isSelected = selectedCategories.contains(category);
                return CategoryPickerItem(
                  category: category,
                  isSelected: isSelected,
                  onSelectedCategory: selectCategory,
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
        ? 'Seleccionar ${selectedCategories.length} Categorías'
        : 'Continuar';

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Constants.COLOR_PRIMARY,
        child: Column(children: [
          CustomButton(onPressed: submit, title: label),
        ]));
  }

  void selectCategory(Category category) {
    if (widget.isMultiSelection) {
      final isSelected = selectedCategories.contains(category);
      setState(() => isSelected
          ? selectedCategories.remove(category)
          : selectedCategories.add(category));
    } else {
      Navigator.pop(context, category);
    }
  }

  void submit() {
    if (widget.isMultiSelection) {
      Navigator.pop(context, selectedCategories);
    } else {
      Navigator.pop(context, null);
    }
  }
}
