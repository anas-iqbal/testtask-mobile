import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:recipesapp/models/ingredients_response_model.dart';
import 'package:recipesapp/services/food_services.dart';
import 'package:recipesapp/utills/dialogs.dart';
import 'package:recipesapp/utills/exception_handler.dart';

class IngredientController extends GetxController {
  var isLoading = false.obs;
  var listIngredients = <IngredientsResponseModel>[].obs;
  var listSelectedIngredients = <String>[].obs;

  TextEditingController dateController = TextEditingController();
  var selectedDate = DateTime.now().obs;
  FoodService recipeService = FoodService();

  @override
  void onInit() {
    super.onInit();
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value);
    dateController.text = formattedDate;
    getIngredients();
  }

  chooseDate() async {
    int currentYear = int.parse(DateFormat.y().format(DateTime.now()));

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(
          DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
      //initialEntryMode: DatePickerEntryMode.input,
      // initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Date',
      fieldHintText: 'Month/Date/Year',
      // selectableDayPredicate: disableDate
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
      dateController.text = formattedDate;
    }
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

  checkIfSelected(String) {
    if (listSelectedIngredients.contains(String)) {
      return true;
    } else {
      return false;
    }
  }

  void toggleSelection(String? title, bool? value) async {
    if (checkIfSelected(title)) {
      listSelectedIngredients.remove(title);
      listIngredients.refresh();
    } else {
      if (dateValidation(title)) {
        listSelectedIngredients.add(title!);
        listIngredients.refresh();
      } else {
        await Get.dialog(
            const GenericDialog(
                message:
                    "Ingredient expired, please choose different ingredient"),
            barrierDismissible: false);
      }
    }
  }

  bool dateValidation(String? title) {
    IngredientsResponseModel? selectedIngredient =
        listIngredients.firstWhere((element) => element.title == title);
    DateTime selectedIngredientUseBy =
        DateTime.parse(selectedIngredient.useBy!);
    selectedIngredientUseBy = DateTime(DateTime.now().year,
        selectedIngredientUseBy.month, selectedIngredientUseBy.day);
    DateTime sDate =
        DateTime(selectedDate.value.year, selectedDate.value.month);
    if (selectedIngredientUseBy.isBefore(sDate)) {
      print("Ingredient expired please select different ingredient");
      return false;
    } else {
      return true;
    }
  }
}
