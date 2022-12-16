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

import '../app/views/models/foodIng.dart';

class FoodIngProvider with ChangeNotifier {
  Set<String> set = {};
  List<foodIngInformation> fetchedFoodList = [];

  String getFoodByIngredientsUrl(List<String> ingList) {
    String val = "";
    if (ingList.isEmpty) {
      val = "salt";
    } else {
      for (int i = 0; i < ingList.length; i++) {
        val += "${ingList[i]},+";
      }
    }

    String url =
        "https://api.spoonacular.com/recipes/findByIngredients?ingredients=$val&number=2&apiKey=c113a9368f95459b97eccc5ff749e30d";

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

  Future<void> fetchFoodDetailsUsingIngrediants(List<String> ingList) async {
    final dataBaseResponse = await http.get(Uri.parse(getFoodByIngredientsUrl(ingList)));
    final extractedFoodDetails = json.decode(dataBaseResponse.body) as List<dynamic>;


    for (int i = 0; i < extractedFoodDetails.length; i++) {
      String foodId = extractedFoodDetails[i]['id'].toString();
      String title = extractedFoodDetails[i]['title'].toString();
      String image = extractedFoodDetails[i]['image'].toString();
      // print(extractedFoodDetails[i]['id']);
      // print(extractedFoodDetails[i]['title']);
      // print(extractedFoodDetails[i]['image']);
      // print(extractedFoodDetails[i]['missedIngredients'] as List<dynamic>);
      // print(extractedFoodDetails[i]['usedIngredients'] as List<dynamic>);
      // print(extractedFoodDetails[i]['unusedIngredients'] as List<dynamic>);

      List<dynamic> list1 = extractedFoodDetails[i]['missedIngredients'] as List<dynamic>;
      List<dynamic> list2 = extractedFoodDetails[i]['usedIngredients'] as List<dynamic>;
      List<dynamic> list3 = [list1, list2].expand((x) => x).toList();
      // print("");
      // print("list-1");
      // print(list1);
      // print("list-2");
      // print(list2);
      // print("list-3");
      // print(list3);

      List<dynamic> videoUniqueIdList = [];
      
      final dataBaseResponse2 = await http.get(Uri.parse(getYoutubeVideoUniqueIdUrl(extractedFoodDetails[i]['title'])));
      final extractedVideoDetails = json.decode(dataBaseResponse2.body) as Map<String, dynamic>;
      final foodVideoIdList = [];

      // print("");
      // print("");
      // print(extractedVideoDetails['items']);
      for (int j = 0; j < min(3, extractedVideoDetails['items'].length); j++) {
        String videoId = extractedVideoDetails['items'][j]['id']['videoId'];
        foodVideoIdList.add(getYoutubeVideoLink(videoId));
      }

      foodIngInformation foodInfo = new foodIngInformation(
        foodId: foodId,
        title: title,
        image: image,
        ingList: list3,
        foodVideoList: foodVideoIdList,
      );
      fetchedFoodList.add(foodInfo);
      notifyListeners();
    }
  }
}
 */