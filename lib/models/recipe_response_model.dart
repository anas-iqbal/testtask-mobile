class RecipeResponseModel {
  String? title;
  List<String>? ingredients;

  RecipeResponseModel({this.title, this.ingredients});

  RecipeResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    ingredients = json['ingredients'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['ingredients'] = this.ingredients;
    return data;
  }
}
