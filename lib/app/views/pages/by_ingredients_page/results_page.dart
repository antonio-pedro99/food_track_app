import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:food_track_app/app/views/pages/by_ingredients_page/food_by_ingr_page.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';

class ResultPages extends StatefulWidget {
  const ResultPages({super.key, required this.query});

  final Query query;
  @override
  State<ResultPages> createState() => _ResultPagesState();
}

class _ResultPagesState extends State<ResultPages> {
  late Future<List<FoodByIngredient>?> _data;
  @override
  void initState() {
    super.initState();

    print(widget.query.ingredients);
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    _data = RestAPIWrapper.fetchFoodByIngredients(widget.query.ingredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: FutureBuilder<List<FoodByIngredient>?>(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var results = snapshot.data;
                return ListView.builder(
                    itemCount: results!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => FoodDetailsPage(
                                    foodByIngredient: results[index],
                                    tag: "${results[index].foodId}$index",
                                    title: "Food Details"))),
                        child: Hero(
                            tag: "${results[index].foodId}$index",
                            child: FoodTile(
                              foodByIngredient: results[index],
                            )),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
