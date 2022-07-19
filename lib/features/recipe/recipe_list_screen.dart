import 'package:flutter/material.dart';
import 'package:recipesapp/features/recipe/recipe_controller.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/models/recipe_response_model.dart';
import 'package:recipesapp/widgets/loader_widget.dart';
import 'package:get/get.dart';

import '../ingredients/ingredient_selection_controller.dart';

class RecipeListScreen extends StatelessWidget {
  RecipeListScreen({Key? key}) : super(key: key);
  final RecipeControler recipeController = RecipeControler();
  @override
  Widget build(BuildContext context) {
    recipeController.getRecipes();
    var height = Get.height;
    return Obx(
      () => LoaderWidget(
          isTrue: recipeController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(title: const Text("Recipes")),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  recipeController.listRecipes.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: recipeController.listRecipes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return listTile(
                                    recipeController.listRecipes[index]);
                              }),
                        )
                      : Container()
                ],
              ))),
    );
  }

  Widget listTile(RecipeResponseModel res) {
    return Card(
      child: ListTile(
        title: Text(res.title!),
        subtitle: Text(res.ingredients!.join(',')),
      ),
    );
  }
}
