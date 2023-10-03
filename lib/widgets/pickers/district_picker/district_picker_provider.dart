import 'package:flutter/cupertino.dart';
import 'package:lya_encuestas/classes/database/data_access/district_da.dart';
import 'package:lya_encuestas/classes/database/models/district.dart';

class DistrictPickerProvider with ChangeNotifier {
  List<District> _districts = [];

  List<District> get districts => _districts;

  DistrictPickerProvider() {
    reloadDistricts();
  }

  void reloadDistricts() {
    loadDistricts().then((districts) {
      _districts = districts;
      notifyListeners();
    });
  }

  Future<List<District>> loadDistricts() async {
    final data = District.parseModelList(await DistrictDA().list(null, null));
    data.sort(ascendingSort);
    print("Recargando distritos");
    return data;
  }

  static int ascendingSort(District c1, District c2) =>
      c1.name.compareTo(c2.name);
}
