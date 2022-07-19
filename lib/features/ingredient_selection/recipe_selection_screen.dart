import 'package:flutter/material.dart';
import 'package:recipesapp/features/ingredient_selection/recipe_selection_controller.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/widgets/loader_widget.dart';
import 'package:get/get.dart';

class RecipeSelectionScreen extends StatelessWidget {
  RecipeSelectionScreen({Key? key}) : super(key: key);
  final RecipeController recipeController = Get.put(RecipeController());
  final List<String> entries = <String>['A', 'B', 'C'];

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Obx(
      () => LoaderWidget(
          isTrue: recipeController.isLoading.value,
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
                          onTap: recipeController.chooseDate,
                          controller: recipeController.dateController,
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
                  recipeController.listIngredients.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount:
                                  recipeController.listIngredients.length,
                              itemBuilder: (BuildContext context, int index) {
                                return listTile(
                                    recipeController.listIngredients[index]);
                              }),
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
          value: recipeController.checkIfSelected(res.title),
          onChanged: (bool? value) {
            recipeController.toggleSelection(res.title, value);
          },
          secondary: const Icon(Icons.add_business_outlined),
        ),
        Divider()
      ],
    );
  }
}
