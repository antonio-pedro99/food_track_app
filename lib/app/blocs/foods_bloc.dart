import 'dart:async';

import 'package:food_track_app/app/blocs/bloc.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:rxdart/rxdart.dart';

class FoodByNameListBloc implements Bloc {
  final _client = RestAPIWrapper();
  final _searchQueryController = StreamController<String?>();
  Sink<String?> get searchQuery => _searchQueryController.sink;
  late Stream<List<Food>?> foodsStreams;

  FoodByNameListBloc() {
    foodsStreams = _searchQueryController.stream
        .startWith(null) // 1
        .debounceTime(const Duration(milliseconds: 1000)) // 2
        .switchMap(
            // 3
            (query) {
      print(query);
      return _client
          .fetchFoodDetailsUsingDishNames(query)
          .asStream()
          .startWith(null);
    });
  }

  @override
  void dispose() {
    _searchQueryController.close();
  }
}
