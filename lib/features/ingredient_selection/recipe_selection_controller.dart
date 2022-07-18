import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/services/recipe_services.dart';
import 'package:recipesapp/utills/exception_handler.dart';

class RecipeController extends GetxController {
  var isLoading = false.obs;
  var listIngredients = <IngredientsResponseModel>[].obs;
  var listSelectedIngredients = <String>[].obs;

  TextEditingController dateController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  RecipeService recipeService = RecipeService();

  @override
  void onInit() {
    super.onInit();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    dateController.text = formattedDate;
    getIngredients();
  }

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value,
        firstDate: DateTime(2000),
        lastDate: DateTime(2024),
        //initialEntryMode: DatePickerEntryMode.input,
        // initialDatePickerMode: DatePickerMode.year,
        helpText: 'Select DOB',
        cancelText: 'Close',
        confirmText: 'Confirm',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter valid date range',
        fieldLabelText: 'DOB',
        fieldHintText: 'Month/Date/Year',
        selectableDayPredicate: disableDate);
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  getIngredients() async {
    isLoading(true);
    try {
      var res = await recipeService.getIngrdients();
      listIngredients(res);
    } catch (e) {
      ExceptionHandler().handleException(e as Exception);
    } finally {
      isLoading(false);
    }
  }

  checkIfSelected(String) {}
}
