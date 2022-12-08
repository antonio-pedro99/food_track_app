import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app/views/models/food_info.dart';

class FoodProvider with ChangeNotifier {
  Set<String> set = {};
  final List<Food> _fetchedFoodList = [];

  Future<List<Food>> fetchFoodDetailsUsingDishNames(
    BuildContext context,
    String searchedFood,
  ) async {
    String foodUrl =
        "https://api.edamam.com/api/food-database/v2/parser?app_id=1aa17d2f&app_key=82a4456156cbb0333c85fa600fae034c%09&ingr=";
    String recipeUrl =
        "https://api.edamam.com/api/recipes/v2?type=public&app_id=34d7530d&app_key=6f735adbec6cad285898e754e8f52588";
    final dataBaseResponse =
        await http.get(Uri.parse("$foodUrl/$searchedFood"));
    final extractedFoodDetails =
        json.decode(dataBaseResponse.body) as Map<String, dynamic>;

    var tmpResults = extractedFoodDetails["hints"];

    for (var item in tmpResults) {
      if (!item.containsKey("food")) {
        continue;
      }
      var food = item["food"];

      if (!food.containsKey("label")) {
        continue;
      }

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

        _fetchedFoodList.add(Food(
          foodId: food.containsKey("foodId") ? food["foodId"] : "-no-foodId-",
          label: food.containsKey("label") ? food["label"] : "-no-label-",
          knownAs:
              food.containsKey("knownAs") ? food["knownAs"] : "-no-know-as-",
          nutrients: food.containsKey("nutrients") ? food["nutrients"] : [],
          image: food.containsKey("image")
              ? food["image"]
              : "https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/58/null/external-soup-autumn-vitaliy-gorbachev-flat-vitaly-gorbachev.png",
          recipe: food["recipe"],
          ingredientNameList: recipe["ingredientLines"] as List<dynamic>,
          ingredientList: recipe["ingredients"] as List<dynamic>,
        ));
        notifyListeners();
      }
    }
    return _fetchedFoodList;
  }
}
