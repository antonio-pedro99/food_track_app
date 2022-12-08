import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/models/food_info.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';
import 'package:food_track_app/app/views/widgets/text_field.dart';
import 'package:food_track_app/providers/api_details.dart';
import 'package:provider/provider.dart';

class FoodByNamePage extends StatefulWidget {
  const FoodByNamePage({super.key, required this.title});

  final String title;

  @override
  State<FoodByNamePage> createState() => _FoodByNamePageState();
}

class _FoodByNamePageState extends State<FoodByNamePage> {
  final TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var foodProvider = Provider.of<FoodProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.receipt_long))
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
                foodProvider.fetchFoodDetailsUsingDishNames(context, value);
              },
            ),
            const SizedBox(height: 24),
            Flexible(
                child: FutureBuilder<List<Food>>(
                    future: foodProvider.fetchFoodDetailsUsingDishNames(
                        context, searchEditingController.text),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      var result = snapshot.data!;
                      return ListView.builder(
                          itemCount: result.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => FoodDetailsPage(
                                      food:result[index] ,
                                        tag: "${result[index].foodId}$index",
                                        title: "Food Details")),
                              ),
                              child: Hero(
                                  tag: "${result[index].foodId}$index",
                                  child: FoodTile(
                                    food: result[index],
                                  )),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }
}
