import 'package:flutter/material.dart';
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
              controller: ingredientsEditingController,
              hint: "Enter any ingredients",
              icon: Icons.search,
            ),
            const SizedBox(height: 8),
            CustomTextField(
              controller: ingredientsEditingController,
              hint: "Enter any nutrition",
              icon: Icons.search,
            ),
            const SizedBox(height: 24),
            Flexible(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          height: 100,
                          color: Colors.primaries[index % 10]);
                    }))
          ],
        ),
      ),
    );
  }
}
