import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:food_track_app/app/views/pages/by_ingredients_page/food_by_ingr_page.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_nutrients_tile.dart';

class ResultPages extends StatefulWidget {
  const ResultPages({super.key, required this.query});

  final Query query;
  @override
  State<ResultPages> createState() => _ResultPagesState();
}

class _ResultPagesState extends State<ResultPages> {
  late Future<List<FoodNutrientsInformation>?> _data;
  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    _data = RestAPIWrapper.fetchFoodDetailsUsingNutrients(widget.query);
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
          child: FutureBuilder<List<FoodNutrientsInformation>?>(
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
                                    nutrientFood: results[index],
                                    tag: "${results[index]}$index",
                                    title: "Food Details"))),
                        child: Hero(
                            tag: "${results[index]}$index",
                            child: FoodNutrientTile(
                              food: results[index],
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
