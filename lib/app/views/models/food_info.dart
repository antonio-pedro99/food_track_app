// ignore_for_file: camel_case_types

class foodInformation {
  String foodId;
  String label;
  String knownAs;
  dynamic nutrients;
  String image;
  dynamic recipe;
  List<dynamic> ingredientNameList;
  List<dynamic> ingredientList;

  foodInformation({
    required this.foodId,
    required this.label,
    required this.knownAs,
    required this.nutrients,
    required this.image,
    required this.recipe,
    required this.ingredientNameList,
    required this.ingredientList,
  });
}
