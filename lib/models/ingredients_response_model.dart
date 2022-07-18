class IngredientsResponseModel {
  String? title;
  String? useBy;

  IngredientsResponseModel({this.title, this.useBy});

  IngredientsResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    useBy = json['use-by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['use-by'] = this.useBy;
    return data;
  }
}
