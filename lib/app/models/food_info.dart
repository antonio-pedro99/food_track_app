class Food {
  String title;
  String knownAs;
  dynamic nutrients;
  String image;
  dynamic recipe;
  List<dynamic> ingredientNameList;
  List<dynamic> ingredientList;
  List<dynamic> foodVideoList;

  Food(
      {required this.title,
      required this.knownAs,
      required this.nutrients,
      required this.image,
      required this.recipe,
      required this.ingredientNameList,
      required this.ingredientList,
      required this.foodVideoList});
}

class FoodNutrientsInformation {
  String title;
  String image;

  String calories;
  String protein;
  String fat;
  String carbs;

  List<dynamic> ingList;
  List<dynamic> foodVideoList;

  FoodNutrientsInformation({
    required this.title,
    required this.image,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.ingList,
    required this.foodVideoList,
  });

  @override
  String toString() {
    return "$calories $title $foodVideoList $ingList";
  }
}
