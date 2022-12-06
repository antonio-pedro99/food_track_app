import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/by_ingredients_page/results_page.dart';
import 'package:food_track_app/app/views/theme/colors.dart';
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
  RangeValues calories = const RangeValues(0, 100);
  RangeValues protein = const RangeValues(0, 100);
  RangeValues fat = const RangeValues(0, 100);
  RangeValues carbohydrates = const RangeValues(0, 100);
  RangeValues sugar = const RangeValues(0, 100);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomTextField(
              controller: ingredientsEditingController,
              hint: "Enter any ingredients",
              icon: Icons.search,
            ),
            const SizedBox(height: 8),
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
                labels: RangeLabels(
                    fat.start.toStringAsFixed(1), fat.end.toStringAsFixed(1)),
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
                labels: RangeLabels(carbohydrates.start.toStringAsFixed(1),
                    carbohydrates.end.toStringAsFixed(1)),
                min: 0,
                max: 100,
                divisions: 8,
                onChanged: ((value) {
                  setState(() => carbohydrates = value);
                })),
            const SizedBox(height: 8),
            const Text("Select sugar"),
            RangeSlider(
                values: sugar,
                labels: RangeLabels(sugar.start.toStringAsFixed(1),
                    sugar.end.toStringAsFixed(1)),
                min: 0,
                max: 100,
                divisions: 8,
                onChanged: ((value) {
                  setState(() => sugar = value);
                })),
            const Spacer(),
            MaterialButton(
                hoverColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(55)),
                height: 56,
                minWidth: MediaQuery.of(context).size.width,
                color: AppColorSchema.flexSchemeLight.primary,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ResultPages())),
                child: const Text("Search"))
          ],
        ),
      ),
    );
  }
}
