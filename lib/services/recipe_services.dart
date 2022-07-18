import 'dart:convert';

import 'package:recipesapp/api/dio_client.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/utills/app_constants.dart';

class RecipeService {
  Future<List<IngredientsResponseModel>> getIngrdients() async {
    DioClient dioClient = DioClient();
    var res = await dioClient.get(APIConstants.getClinicsAPI);
    List<IngredientsResponseModel> ingredients = [];
    res.forEach((element) {
      ingredients.add(IngredientsResponseModel.fromJson(element));
    });
    return ingredients;
  }
}
