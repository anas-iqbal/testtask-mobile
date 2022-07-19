import 'package:flutter/material.dart';
import 'package:recipesapp/features/recipe/recipe_list_screen.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/widgets/loader_widget.dart';
import 'package:get/get.dart';

import 'ingredient_selection_controller.dart';

class IngredientSelectionScreen extends StatelessWidget {
  IngredientSelectionScreen({Key? key}) : super(key: key);
  final IngredientController ingredientController =
      Get.put(IngredientController());

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Obx(
      () => LoaderWidget(
          isTrue: ingredientController.isLoading.value,
          child: Scaffold(
              appBar: AppBar(title: const Text("Select Ingredients")),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.8,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onTap: ingredientController.chooseDate,
                          controller: ingredientController.dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(),
                            labelText: 'Date',
                            hintText: 'Select Date',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: Text(
                      "Available Ingredients",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ingredientController.listIngredients.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  ingredientController.listIngredients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return listTile(ingredientController
                                    .listIngredients[index]);
                              }),
                        )
                      : Container(),
                  ingredientController.listIngredients.value.isNotEmpty
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20)),
                          onPressed: () {
                            Get.to(RecipeListScreen());
                          },
                          child: Container(
                            height: 70,
                            width: Get.width,
                            alignment: Alignment.center,
                            child: Text("Check Recipe"),
                          ),
                        )
                      : Container()
                ],
              ))),
    );
  }

  Widget listTile(IngredientsResponseModel res) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(res.title ?? ''),
          value: ingredientController.checkIfSelected(res.title),
          onChanged: (bool? value) {
            ingredientController.toggleSelection(res.title, value);
          },
          secondary: const Icon(Icons.add_business_outlined),
        ),
        Divider()
      ],
    );
  }
}
