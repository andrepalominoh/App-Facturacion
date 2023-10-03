import 'package:flutter/cupertino.dart';
import 'package:lya_encuestas/classes/database/models/period.dart';
import 'package:lya_encuestas/classes/http/services/period_service.dart';

class PeriodPickerProvider with ChangeNotifier {
  List<Period> _periods = [];

  List<Period> get periods => _periods;

  PeriodPickerProvider() {
    reloadPeriods();
  }

  void reloadPeriods() {
    loadPeriods().then((periods) {
      _periods = periods;
      notifyListeners();
    });
  }

  Future<List<Period>> loadPeriods() async {
    final data = Period.parseModelList(await PeriodService().list());
    data.sort(ascendingSort);
    print("Recargando periodos");
    return data;
  }

  static int ascendingSort(Period c1, Period c2) => c1.code.compareTo(c2.code);
}
