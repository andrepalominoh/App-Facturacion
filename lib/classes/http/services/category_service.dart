import 'package:lya_encuestas/classes/database/base_model.dart';
import 'package:lya_encuestas/classes/database/models/category.dart';
import 'package:lya_encuestas/assets/constants.dart';
import 'package:lya_encuestas/classes/http/api_service.dart';

class CategoryService extends APIService {
  Future<List<Category>> list(int pollsterUserId, int periodId) async {
    var parameters = {
      "pollster_user_id": pollsterUserId.toString(),
      "period_id": periodId.toString()
    };
    List<Category> result = Category.parseModelList(await responseToModelList(
        Constants.API_REQUEST_CATEGORY_LIST, parameters));
    return result;
  }

  @override
  BaseModel parseEntityFromJSON(Map<String, dynamic> json) {
    return Category(
        id: int.parse(json["category_id"].toString()),
        code: json["code"],
        name: json["name"]);
  }
}
