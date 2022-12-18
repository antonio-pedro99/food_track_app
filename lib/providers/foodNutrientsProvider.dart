/* // ignore_for_file: unused_import, library_prefixes, depend_on_referenced_packages, camel_case_types, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables, unnecessary_new, unnecessary_this, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../app/views/models/foodNutrients.dart';

class FoodNutrientsProvider with ChangeNotifier {
  Set<String> set = {};
  List<foodNutrientsInformation> fetchedFoodList = [];

  String getFoodNutrientsUrl(
    int minProtein,
    int maxProtein,
    int minFat,
    int maxFat,
    int minCalorie,
    int maxCalorie,
    int minCarbs,
    int maxCarbs,
  ) {
    String url = "https://api.spoonacular.com/recipes/findByNutrients?minProtein=${minProtein}&maxProtein=${maxProtein}&minFat=${minFat}&maxFat=${maxFat}&minCalorie=${minCalorie}&maxCalorie=${maxCalorie}&minCarbs=${minCarbs}&maxCarbs=${maxCarbs}&number=4&apiKey=c113a9368f95459b97eccc5ff749e30d";

    return url;
  }

  String getFoodIngFromFoodUrl(String foodName) {
    String url = "https://api.edamam.com/api/recipes/v2?type=public&app_id=34d7530d&app_key=6f735adbec6cad285898e754e8f52588&q=${foodName}";

    return url;
  }

  String getYoutubeVideoUniqueIdUrl(String foodName) {
    String url = "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=how%20to%20make%20${foodName}%20&key=AIzaSyA8KD55XiccMczG_5LHEl96coRYD-0AQ1M";

    return url;
  }

  String getYoutubeVideoLink(String videoId) {
    String url = "https://www.youtube.com/watch?v=${videoId}";

    return url;
  }

  Future<void> fetchFoodDetailsUsingNutrients(
    int minProtein,
    int maxProtein,
    int minFat,
    int maxFat,
    int minCalorie,
    int maxCalorie,
    int minCarbs,
    int maxCarbs,
  ) async {
    final dataBaseResponse = await http.get(
      Uri.parse(
        getFoodNutrientsUrl(
          minProtein,
          maxProtein,
          minFat,
          maxFat,
          minCalorie,
          maxCalorie,
          minCarbs,
          maxCarbs,
        ),
      ),
    );
    final extractedFoodDetails =
        json.decode(dataBaseResponse.body) as List<dynamic>;

    for (int i = 0; i < extractedFoodDetails.length; i++) {
      String foodId = extractedFoodDetails[i]['id'].toString();
      String title = extractedFoodDetails[i]['title'].toString();
      String image = extractedFoodDetails[i]['image'].toString();

      String calories = extractedFoodDetails[i]['calories'].toString();
      String protein = extractedFoodDetails[i]['protein'].toString();
      String fat = extractedFoodDetails[i]['fat'].toString();
      String carbs = extractedFoodDetails[i]['carbs'].toString();

      final dataBaseResponse2 = await http.get(Uri.parse(getYoutubeVideoUniqueIdUrl(title)));
      final extractedVideoDetails = json.decode(dataBaseResponse2.body) as Map<String, dynamic>;

      // print("");
      // print("");
      // print(extractedVideoDetails['items']);
      final foodVideoIdList = [];
      for (int j = 0; j < min(3, extractedVideoDetails['items'].length); j++) {
        String videoId = extractedVideoDetails['items'][j]['id']['videoId'];
        foodVideoIdList.add(getYoutubeVideoLink(videoId));
      }

      final dataBaseResponse3 = await http.get(Uri.parse(getFoodIngFromFoodUrl(title)));
      final extractedIngDetails = json.decode(dataBaseResponse3.body) as Map<String, dynamic>;


      // print(extractedIngDetails['hits'][0]['recipe']['ingredients']);
      foodNutrientsInformation foodInfo = new foodNutrientsInformation(
        foodId: foodId,
        title: title,
        image: image,
        calories: calories,
        protein: protein,
        fat: fat,
        carbs: carbs,
        ingList: extractedIngDetails['hits'][0]['recipe']['ingredients'],
        foodVideoList: foodVideoIdList,
      );

      fetchedFoodList.add(foodInfo);
      notifyListeners();

      print(foodInfo.foodId);
      print(foodInfo.title);
      print(foodInfo.image);

      print(foodInfo.calories);
      print(foodInfo.protein);
      print(foodInfo.fat);
      print(foodInfo.carbs);

      print(foodInfo.ingList);
      print(foodInfo.foodVideoList);

      print("");

    }
  }
}
 */