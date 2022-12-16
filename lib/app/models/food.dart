// ignore_for_file: camel_case_types

class FoodByIngredient {
  final String foodId;
  final String title;
  final String image;
  final List<dynamic> ingList;
  final List<dynamic> foodVideoList;

  FoodByIngredient({
    required this.foodId,
    required this.title,
    required this.image,
    required this.ingList,
    required this.foodVideoList,
  });
}
