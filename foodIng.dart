// ignore_for_file: camel_case_types

class foodIngInformation {
  String foodId;
  String title;
  String image;
  List<dynamic> ingList;
  List<dynamic> foodVideoList;

  foodIngInformation({
    required this.foodId,
    required this.title,
    required this.image,
    required this.ingList,
    required this.foodVideoList,
  });
}