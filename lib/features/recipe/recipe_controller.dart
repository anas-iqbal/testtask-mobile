import 'package:get/get.dart';
import 'package:recipesapp/features/ingredients/ingredient_selection_controller.dart';
import 'package:recipesapp/models/recipe_response_model.dart';
import 'package:recipesapp/services/food_services.dart';
import 'package:recipesapp/utills/exception_handler.dart';

class RecipeControler extends GetxController {
  final recipeController = Get.find<IngredientController>();
  FoodService recipeService = FoodService();
  var listRecipes = <RecipeResponseModel>[].obs;

  var isLoading = false.obs;

  getRecipes() async {
    isLoading(true);
    try {
      var res = await recipeService
          .getRecipes(recipeController.listSelectedIngredients.value);
      listRecipes(res);
    } catch (e) {
      ExceptionHandler().handleException(e as Exception);
    } finally {
      isLoading(false);
    }
  }
}
