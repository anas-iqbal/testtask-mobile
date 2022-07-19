import 'dart:convert';

import 'package:recipesapp/api/dio_client.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/models/recipe_response_model.dart';
import 'package:recipesapp/utills/app_constants.dart';

class FoodService {
  Future<List<IngredientsResponseModel>> getIngrdients() async {
    DioClient dioClient = DioClient();
    var res = await dioClient.get(APIConstants.getIngredients);
    List<IngredientsResponseModel> ingredients = [];
    res.forEach((element) {
      ingredients.add(IngredientsResponseModel.fromJson(element));
    });
    return ingredients;
  }

  Future<List<RecipeResponseModel>> getRecipes(List<String> list) async {
    DioClient dioClient = DioClient();
    var res = await dioClient.get(APIConstants.getRecipes,
        queryParam: {"ingredients": list.join(",")});
    List<RecipeResponseModel> recipes = [];
    res.forEach((element) {
      recipes.add(RecipeResponseModel.fromJson(element));
    });
    return recipes;
  }
}
