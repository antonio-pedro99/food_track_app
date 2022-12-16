import 'dart:async';

import 'package:food_track_app/app/blocs/bloc.dart';
import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:rxdart/rxdart.dart';
/* 
class FoodsByIngredientsList extends Bloc {
  final _client = RestAPIWrapper();
  final _searchQueryController = StreamController<String?>();
  Sink<String?> get searchQuery => _searchQueryController.sink;
  late Stream<List<FoodByIngredient>?> foodsStreams;

  FoodsByIngredientsList() {
    foodsStreams = _searchQueryController.stream
        .startWith(null) // 1
        .debounceTime(const Duration(milliseconds: 800)) // 2
        .switchMap(
            // 3
            (query) {
      return _client
          .fetchFoodByIngredients(query!.split(","))
          .asStream()
          .startWith(null);
    });
  }

  void searchFood(String name) => _searchQueryController.add(name);

  Stream<List<FoodByIngredient>?> get results => foodsStreams;

  @override
  void dispose() {}
}
 */