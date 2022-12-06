import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/text_field.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.receipt_long))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            CustomTextField(
              controller: searchEditingController,
              hint: "Type the name of the Food",
              icon: Icons.search,
            ),
            const SizedBox(height: 24),
            Flexible(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const FoodDetailsPage(
                                    title: "Food Details"))),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            height: 180,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://spoonacular.com/recipeImages/640803-312x231.jpg",
                                    ))),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
