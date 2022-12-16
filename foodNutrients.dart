// ignore_for_file: camel_case_types

class foodNutrientsInformation {
  String foodId;
  String title;
  String image;

  String calories;
  String protein;
  String fat;
  String carbs;

  List<dynamic> ingList;
  List<dynamic> foodVideoList;


  foodNutrientsInformation({
    required this.foodId,
    required this.title,
    required this.image,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.ingList,
    required this.foodVideoList,
  });
}
