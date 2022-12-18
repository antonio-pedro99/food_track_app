import 'package:flutter/material.dart';
import 'package:food_track_app/app/blocs/foods_bloc.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/providers/bloc_provider.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';
import 'package:food_track_app/app/views/widgets/text_field.dart';

class FoodByNamePage extends StatefulWidget {
  const FoodByNamePage({super.key, required this.title});

  final String title;

  @override
  State<FoodByNamePage> createState() => _FoodByNamePageState();
}

class _FoodByNamePageState extends State<FoodByNamePage> {
  late Future<List<Food>?> _foods;

  final TextEditingController searchEditingController = TextEditingController();

  Future<void> searchFood(String name) async {
    _foods = RestAPIWrapper.fetchFoodDetailsUsingDishNames(name);
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.notes))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: searchEditingController,
              hint: "Type the name of the Food",
              icon: Icons.search,
              onEnter: (value) {
                searchFood(value);
                setState(() => isSearching = true);
              },
            ),
            const SizedBox(height: 24),
            Flexible(
                child: isSearching
                    ? FutureBuilder<List<Food?>?>(
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
                                                food: results[index],
                                                tag:
                                                    "${results[index]!.foodId}$index",
                                                title: "Food Details"))),
                                    child: Hero(
                                        tag: "${results[index]!.foodId}$index",
                                        child: FoodTile(
                                          food: results[index],
                                        )),
                                  );
                                });
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        future: _foods,
                      )
                    : const Center(
                        child: Text("Search Something"),
                      ))
          ],
        ),
      ),
    );
  }
}
