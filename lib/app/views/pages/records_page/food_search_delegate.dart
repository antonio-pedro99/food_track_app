import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/providers/food.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';

import '../details_page/details_page.dart';

class FoodSearchDelegate extends SearchDelegate<Food> {
  final FoodSearchService foodSearchService;
  FoodSearchDelegate(this.foodSearchService);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Search Something"));
    }
    foodSearchService.searchFood(query);
    return buildResultToProvider(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Search Something"));
    }
    foodSearchService.searchFood(query);
    return buildResultToProvider(context);
  }

  Widget buildResultToProvider(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final resultsValue = ref.watch(searchResultsProvider);

        return resultsValue.when(
            data: (result) {
              return result.when((foods) {
                return ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => FoodDetailsPage(
                                  food: foods[index],
                                  tag: "${foods[index].foodId}$index",
                                  title: "Food Details")),
                        ),
                        child: Hero(
                            tag: "${foods[index].foodId}$index",
                            child: FoodTile(
                              food: foods[index],
                            )),
                      );
                    });
              }, error: (e) => Container());
            },
            error: (error, e) {
              return Container();
            },
            loading: () => const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
