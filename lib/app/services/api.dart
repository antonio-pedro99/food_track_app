import 'dart:convert';
import 'dart:math';

import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:http/http.dart' as http;

class RestAPIWrapper {
  static Future<List<Food>?> fetchFoodDetailsUsingDishNames(
    String? searchedFood,
  ) async {
    List<Food> fetchedFoodList = [];

    Set<String> set = {};
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
      var videoList = [];
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
        if (set.contains(food["foodId"])) {
          continue;
        }
        set.add(food["foodId"]);
        final dataBaseResponse2 =
            await http.get(Uri.parse(_getYoutubeVideoUniqueIdUrl(foodLabel)));
        final extractedVideoDetails =
            json.decode(dataBaseResponse2.body) as Map<String, dynamic>;
        final foodVideoIdList = [];

        for (int j = 0;
            j < min(3, extractedVideoDetails['items'].length);
            j++) {
          String videoId = extractedVideoDetails['items'][j]['id']['videoId'];

          foodVideoIdList.add({
            "url": _getYoutubeVideoLink(videoId),
            "thumbnails": extractedVideoDetails["items"][j]["snippet"]
                ["thumbnails"]["default"]["url"]
          });
        }
        fetchedFoodList.add(Food(
            foodId: food.containsKey("foodId") ? food["foodId"] : "0",
            label: food.containsKey("label") ? food["label"] : "-no-label-",
            knownAs:
                food.containsKey("knownAs") ? food["knownAs"] : "-no-know-as-",
            nutrients: food.containsKey("nutrients") ? food["nutrients"] : [],
            image: food.containsKey("image")
                ? food["image"]
                : "https://photo-cdn2.icons8.com/LBUcniDezcjVj_WfynHIGLeSu3B9lYhteQL_nTSXCPM/rs:fit:1619:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5h/c3NldHMvYXNzZXRz/L3NhdGEvb3JpZ2lu/YWwvNDgyLzAzNzRk/ZTI5LTcyYzYtNDgx/ZS1iOGFlLWI3YTE1/M2NmMWI1Mi5qcGc.jpg",
            recipe: food["recipe"],
            ingredientNameList: recipe["ingredientLines"] as List<dynamic>,
            ingredientList: recipe["ingredients"] as List<dynamic>,
            foodVideoList: foodVideoIdList));
      }
    }
    return fetchedFoodList;
  }

  static Future<List<FoodByIngredient>?> fetchFoodByIngredients(
      List<String> ingList) async {
    final dataBaseResponse =
        await http.get(Uri.parse(_getFoodByIngredientsUrl(ingList)));
    final extractedFoodDetails =
        json.decode(dataBaseResponse.body) as List<dynamic>;
    List<FoodByIngredient> fetchedFoodList = [];

    for (int i = 0; i < extractedFoodDetails.length; i++) {
      String foodId = extractedFoodDetails[i]['id'].toString();
      String title = extractedFoodDetails[i]['title'].toString();
      String image = extractedFoodDetails[i]['image'].toString();

      List<dynamic> list1 =
          extractedFoodDetails[i]['missedIngredients'] as List<dynamic>;
      List<dynamic> list2 =
          extractedFoodDetails[i]['usedIngredients'] as List<dynamic>;
      List<dynamic> list3 = [list1, list2].expand((x) => x).toList();

      final dataBaseResponse2 = await http.get(Uri.parse(
          _getYoutubeVideoUniqueIdUrl(extractedFoodDetails[i]['title'])));
      final extractedVideoDetails =
          json.decode(dataBaseResponse2.body) as Map<String, dynamic>;
      final foodVideoIdList = [];

      for (int j = 0; j < min(3, extractedVideoDetails['items'].length); j++) {
        String videoId = extractedVideoDetails['items'][j]['id']['videoId'];

        foodVideoIdList.add({
          "url": _getYoutubeVideoLink(videoId),
          "thumbnails": extractedVideoDetails["items"][j]["snippet"]
              ["thumbnails"]["default"]["url"]
        });
      }

      fetchedFoodList.add(FoodByIngredient(
        foodId: foodId,
        title: title,
        image: image,
        ingList: list3,
        foodVideoList: foodVideoIdList,
      ));
    }

    return fetchedFoodList;
  }
}

String _getFoodByIngredientsUrl(List<String> ingList) {
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

String _getYoutubeVideoUniqueIdUrl(String foodName) {
  String url =
      "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=25&q=how%20to%20make%20$foodName%20&key=AIzaSyA8KD55XiccMczG_5LHEl96coRYD-0AQ1M";

  return url;
}

String _getYoutubeVideoLink(String videoId) {
  String url = "https://www.youtube.com/watch?v=$videoId";

  return url;
}
