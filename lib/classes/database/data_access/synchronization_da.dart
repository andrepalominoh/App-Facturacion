import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/database/base_da.dart';
import 'package:lya_encuestas/classes/database/models/synchronization.dart';

class SynchronizationDA extends BaseDA {
  Future<void> deleteAllBase() async {
    SynchronizationDA().delete(null);
  }

  @override
  String getTable() {
    return Constants.DB_TABLE_SYNCHRONIZATIONS;
  }

  @override
  Synchronization fillModelData(Map<String, dynamic> data) {
    return Synchronization(
      id: data['id'],
      requestDate: data['request_date'],
    );
  }
}
