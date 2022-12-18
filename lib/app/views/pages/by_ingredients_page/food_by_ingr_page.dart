import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:food_track_app/app/views/pages/by_ingredients_page/results_page.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/theme/colors.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';
import 'package:food_track_app/app/views/widgets/text_field.dart';

class FoodByIngridPage extends StatefulWidget {
  const FoodByIngridPage({super.key, required this.title});

  final String title;

  @override
  State<FoodByIngridPage> createState() => _FoodByIngridPageState();
}

class _FoodByIngridPageState extends State<FoodByIngridPage> {
  final TextEditingController ingredientsEditingController =
      TextEditingController();
  final TextEditingController nutritionEditingController =
      TextEditingController();

  late Future<List<FoodByIngredient>?> _data;

  RangeValues calories = const RangeValues(0, 100);
  RangeValues protein = const RangeValues(0, 100);
  RangeValues fat = const RangeValues(0, 100);
  RangeValues carbohydrates = const RangeValues(0, 100);

  var key = GlobalKey<FormState>();

  int currentIndex = 0;
  bool isByNutrient = false;
  bool isSearching = false;

  Future<void> fetchFoods(List<String> query) async {
    _data = RestAPIWrapper.fetchFoodByIngredients(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: !isByNutrient,
              child: CustomTextField(
                  controller: ingredientsEditingController,
                  hint: "Enter any ingredients",
                  icon: Icons.search,
                  onValidate: (value) {
                    if (value!.isEmpty) {
                      return "Please fill this";
                    }
                    return null;
                  },
                  onEnter: (s) {
                    fetchFoods(s.split(","));
                    setState(() => isSearching = true);
                  }),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Search By Nutrients"),
                Switch(
                    value: isByNutrient,
                    onChanged: (v) {
                      setState(() {
                        isByNutrient = v;
                        if (isByNutrient) {
                          currentIndex = 1;
                        } else {
                          currentIndex = 0;
                        }
                      });
                    }),
              ],
            ),
            Expanded(
                child: IndexedStack(
              index: currentIndex,
              children: [
                isSearching
                    ? SizedBox(
                        child: FutureBuilder<List<FoodByIngredient>?>(
                          future: _data,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              var results = snapshot.data;
                              return ListView.builder(
                                  itemCount: results!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => FoodDetailsPage(
                                                  foodByIngredient:
                                                      results[index],
                                                  tag:
                                                      "${results[index].foodId}$index",
                                                  title: "Food Details"))),
                                      child: Hero(
                                          tag: "${results[index].foodId}$index",
                                          child: FoodTile(
                                            foodByIngredient: results[index],
                                          )),
                                    );
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      )
                    : const Center(
                        child: Text("Search Something"),
                      ),
                SizedBox(
                    child: ListView(
                  children: [
                    const Text("Select Protein"),
                    RangeSlider(
                        values: protein,
                        //  label: "$protein",
                        labels: RangeLabels(protein.start.toStringAsFixed(1),
                            protein.end.toStringAsFixed(1)),
                        min: 0,
                        max: 100,
                        divisions: 8,
                        onChanged: ((value) {
                          setState(() => protein = value);
                        })),
                    const SizedBox(height: 8),
                    const Text("Select Fat"),
                    RangeSlider(
                        values: fat,
                        labels: RangeLabels(fat.start.toStringAsFixed(1),
                            fat.end.toStringAsFixed(1)),
                        min: 0,
                        max: 100,
                        divisions: 8,
                        onChanged: ((value) {
                          setState(() => fat = value);
                        })),
                    const SizedBox(height: 8),
                    const Text("Select calories"),
                    RangeSlider(
                        values: calories,
                        labels: RangeLabels(calories.start.toStringAsFixed(1),
                            calories.end.toStringAsFixed(1)),
                        min: 0,
                        max: 100,
                        divisions: 8,
                        onChanged: ((value) {
                          setState(() => calories = value);
                        })),
                    const SizedBox(height: 8),
                    const Text("Select carbonates"),
                    RangeSlider(
                        values: carbohydrates,
                        labels: RangeLabels(
                            carbohydrates.start.toStringAsFixed(1),
                            carbohydrates.end.toStringAsFixed(1)),
                        min: 0,
                        max: 100,
                        divisions: 8,
                        onChanged: ((value) {
                          setState(() => carbohydrates = value);
                        })),
                    const SizedBox(height: 8),
                    const SizedBox(height: 38),
                    MaterialButton(
                        hoverColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(55)),
                        height: 56,
                        minWidth: MediaQuery.of(context).size.width,
                        color: AppColorSchema.flexSchemeLight.primary,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResultPages(
                                    query: Query(
                                        minCalorie: calories.start,
                                        maxCalorie: calories.end,
                                        minCarbs: carbohydrates.start,
                                        maxCarbs: carbohydrates.end,
                                        minFat: fat.start,
                                        maxFat: fat.end,
                                        minProtein: protein.start,
                                        maxProtein: protein.end),
                                  )));
                        },
                        child: const Text("Search"))
                  ],
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class Query {
  double? minProtein;
  double? maxProtein;
  double? minFat;
  double? maxFat;
  double? minCalorie;
  double? maxCalorie;
  double? minCarbs;
  double? maxCarbs;

  Query(
      {this.minCalorie,
      this.maxCalorie,
      this.minCarbs,
      this.maxCarbs,
      this.minFat,
      this.maxFat,
      this.minProtein,
      this.maxProtein});
}
