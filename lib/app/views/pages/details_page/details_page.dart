import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/models/ingredient.dart';
import 'package:food_track_app/app/views/widgets/ingredient_tile.dart';
import 'package:food_track_app/app/views/widgets/nutrient_tile.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage(
      {super.key, required this.title, required this.food, this.tag});
  final String title;
  final String? tag;
  final Food food;
  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  var ingredients = <Ingredient>[];
  @override
  void initState() {
    super.initState();

    ingredients = widget.food.ingredientList
        .map<Ingredient>((e) => Ingredient.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.title),
            floating: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Hero(
                  tag: widget.tag!,
                  child: Image.network(
                    widget.food.image,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
              Text(
                widget.food.label,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              const NutrientTile(),
              const SizedBox(height: 24),
              Text(
                'Ingredients',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ingredients.length,
                    itemExtent: 200,
                    itemBuilder: ((context, index) {
                      return IngredientTile(
                        ingredient: ingredients[index],
                      );
                    })),
              ),
              const SizedBox(height: 24),
              Text(
                'How to Cook(video)',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
            ])),
          )
        ],
      ),
    );
  }
}
