// ignore_for_file: unused_import, library_prefixes, depend_on_referenced_packages, camel_case_types, unused_local_variable, avoid_print, prefer_typing_uninitialized_variables, unnecessary_new, unnecessary_this

import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
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

import '../app/views/models/food_info.dart';

class API_Details with ChangeNotifier {
  Set<String> set = {};
  List<foodInformation> fetchedFoodList = [];

  Future<void> fetchFoodDetailsUsingDishNames(
    BuildContext context,
    String searchedFood,
  ) async {
    String foodUrl =
        "https://api.edamam.com/api/food-database/v2/parser?app_id=1aa17d2f&app_key=82a4456156cbb0333c85fa600fae034c%09&ingr=";
    String recipeUrl =
        "https://api.edamam.com/api/recipes/v2?type=public&app_id=34d7530d&app_key=6f735adbec6cad285898e754e8f52588";

    // var foodUrl = Uri.parse(
    //   "https://api.edamam.com/api/food-database/v2/parser?app_id=1aa17d2f&app_key=82a4456156cbb0333c85fa600fae034c%09&ingr=${searchedFood}",
    // );

    // var recipeUrl = Uri.parse(
    //   "https://api.edamam.com/api/recipes/v2?type=public&app_id=34d7530d&app_key=6f735adbec6cad285898e754e8f52588",
    // );

    final dataBaseResponse =
        await http.get(Uri.parse("$foodUrl/$searchedFood"));
    final extractedFoodDetails =
        json.decode(dataBaseResponse.body) as Map<String, dynamic>;
    // final extractedFoodDetails = json.decode(dataBaseResponse.body);
    var tmpResults = extractedFoodDetails["hints"];

    for (var item in tmpResults) {
      if (!item.containsKey("food")) {
        continue;
      }
      var food = item["food"];

      if (!food.containsKey("label")) {
        continue;
      }
      var image = food["image"];
      /////////////////////////////////
      var foodLabel = food["label"];
      var recipeResponse = await http.get(Uri.parse("$recipeUrl&q=$foodLabel"));
      var recipeResults =
          json.decode(recipeResponse.body) as Map<String, dynamic>;
      if (!recipeResults.containsKey("hits")) {
        continue;
      }
      var recipeList = recipeResults["hits"];
      for (int i = 0; i < min(2, recipeList.length); i++) {
        if (recipeList.length == 0 || !recipeList[i].containsKey("recipe")) {
          continue;
        }
        var recipe = recipeList[i]["recipe"];
        if (food == null) {
          continue;
        }
        food["recipe"] = {
          "ingredients": recipe["ingredients"],
          "ingredientLines": recipe["ingredientLines"],
        };

        foodInformation foodInfo = new foodInformation(
          foodId: food.containsKey("foodId") ? food["foodId"] : "-no-foodId-",
          label: food.containsKey("label") ? food["label"] : "-no-label-",
          knownAs: food.containsKey("knownAs") ? food["knownAs"] : "-no-know-as-",
          nutrients: food.containsKey("nutrients") ? food["nutrients"] : {},
          image: food.containsKey("image") ? food["image"] : "https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/58/null/external-soup-autumn-vitaliy-gorbachev-flat-vitaly-gorbachev.png",
          recipe: food["recipe"],
          ingredientNameList: recipe["ingredientLines"] as List<dynamic>,
          ingredientList: recipe["ingredients"] as List<dynamic>,
        );

        this.fetchedFoodList.add(foodInfo);
        notifyListeners();

        print("");
        print(foodInfo.foodId);
        print(foodInfo.label);
        print(foodInfo.knownAs);
        print(foodInfo.nutrients);
        print(foodInfo.image);
        print(foodInfo.ingredientNameList);
        print(foodInfo.ingredientList);
        print("");
      }

      // print(food);
      // print("");
    }

    // int index = 1;
    // extractedFoodDetails.forEach(
    //   (phoneId, phoneData) {
    //     print(index);
    //     print(phoneData);
    //     print("");
    //     index += 1;
    //   },
    // );

    // print("Printing..");
    // print(extractedFoodDetails['text']);
    // print(extractedFoodDetails['label']);

    // final foodUrl = Uri.https(
    //   'aurigacarehealthapplication-default-rtdb.firebaseio.com',
    //   '/PatientsUserPhoneNumberList.json',
    // );

    // final urlParse = Uri.parse(
    //   'https://aurigacare-dpapplication-default-rtdb.firebaseio.com/PatientsUserPhoneNumberList.json',
    // );

    // try {
    //   final dataBaseResponse = await http.get(foodUrl);
    //   final extractedFoodDetails = json.decode(dataBaseResponse.body) as Map<String, dynamic>;

    //   if (extractedFoodDetails.toString() != "null" && extractedFoodDetails.length !=
    //       this.existingPatientsPhoneNumberList.length) {
    //     final List<String> phoneNumberList = [];
    //     extractedFoodDetails.forEach(
    //       (phoneId, phoneData) {
    //         phoneNumberList.add(phoneData['patient_PhoneNumber']);
    //       },
    //     );

    //     existingPatientsPhoneNumberList = phoneNumberList;
    //     notifyListeners();
    //   }
    // }
    // catch (errorVal) {
    //   print("Error Value");
    //   print(errorVal);
    // }
  }
}
