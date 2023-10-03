import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lya_encuestas/classes/database/data_access/district_da.dart';
import 'package:lya_encuestas/classes/database/data_access/type_da.dart';
import 'package:lya_encuestas/classes/database/models/type.dart';
import 'package:http/http.dart' as http;

class TypePickerProvider with ChangeNotifier {
  List<Type> _types = [];
  List<Type> get types => _types;

  TypePickerProvider() {
    reloadTypes();
  }

  void reloadTypes() {
    loadTypes();
    // loadTypes().then((types) {
    //   _types = types;
    //   notifyListeners();
    // });
  }

  Future<void> loadTypes() async {
  // Future<List<Type>>? loadTypes() async {
  //   final data = [];//.parseModelList(await TypeDA().);

    final response = await http.get(Uri.parse('https://api.pedidos.bitz.pe/es/bitz/admin/entity/type/get'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var data=jsonDecode(response.body);
      // return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }

    // data.sort(ascendingSort);
    // print("Recargando distritos");
  }

  // static int ascendingSort(District c1, District c2) =>
  //     c1.name.compareTo(c2.name);
}
