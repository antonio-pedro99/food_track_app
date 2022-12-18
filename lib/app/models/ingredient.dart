class Ingredient {
  String? text;
  double? quantity;
  String? measure;
  String? food;
  double? weight;
  String? foodCategory;
  String? foodId;
  String? image;

  Ingredient(
      {this.text,
      this.quantity,
      this.measure,
      this.food,
      this.weight,
      this.foodCategory,
      this.foodId,
      this.image});

  Ingredient.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? json["name"];
    quantity = json['quantity'] ?? json["amount"];
    measure = json['measure'] ?? json["unit"];
    food = json['food'] ?? json["originalName"];
    weight = json['weight'] ?? 0;
    foodCategory = json['foodCategory'] ?? json["aisle"];
    foodId = json['foodId'] ?? json["id"].toString();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['quantity'] = quantity;
    data['measure'] = measure;
    data['food'] = food;
    data['weight'] = weight;
    data['foodCategory'] = foodCategory;
    data['foodId'] = foodId;
    data['image'] = image;
    return data;
  }
}
