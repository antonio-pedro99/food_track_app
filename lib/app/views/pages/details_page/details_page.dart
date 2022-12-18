import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/models/ingredient.dart';
import 'package:food_track_app/app/views/widgets/ingredient_tile.dart';
import 'package:food_track_app/app/views/widgets/nutrient_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage(
      {super.key,
      required this.title,
      this.foodByIngredient,
      this.nutrientFood,
      this.food,
      this.tag});
  final String title;
  final String? tag;
  final Food? food;
  final FoodByIngredient? foodByIngredient;
  final FoodNutrientsInformation? nutrientFood;
  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  var ingredients = <Ingredient>[];
  var videos = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();

    ingredients = widget.food == null
        ? widget.foodByIngredient != null
            ? widget.foodByIngredient!.ingList
                .map<Ingredient>(
                    (e) => Ingredient.fromJson(e as Map<String, dynamic>))
                .toList()
            : widget.nutrientFood == null
                ? widget.food!.ingredientList
                    .map<Ingredient>(
                        (e) => Ingredient.fromJson(e as Map<String, dynamic>))
                    .toList()
                : widget.nutrientFood!.ingList
                    .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
                    .toList()
        : [];

    videos = widget.foodByIngredient != null
        ? widget.foodByIngredient!.foodVideoList
            .map((e) => e as Map<String, dynamic>)
            .toList()
        : widget.nutrientFood == null
            ? widget.food!.foodVideoList
                .map((e) => e as Map<String, dynamic>)
                .toList()
            : widget.nutrientFood!.foodVideoList
                .map((e) => e as Map<String, dynamic>)
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
                    widget.food != null
                        ? widget.food!.image
                        : widget.foodByIngredient != null
                            ? widget.foodByIngredient!.image
                            : widget.nutrientFood!.image,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildListDelegate.fixed([
              Text(
                widget.food != null
                    ? widget.food!.title
                    : widget.foodByIngredient != null
                        ? widget.foodByIngredient!.title
                        : widget.nutrientFood!.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              const NutrientTile(),
              const SizedBox(height: 24),
              Text(
                'Recipe/Ingredients',
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
              SizedBox(
                height: MediaQuery.of(context).size.height * .35,
                child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                imageUrl: videos[index]["thumbnails"],
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                              )),
                          title: Text(videos[index]["title"]),
                          subtitle: const Text("Type To Play on Youtube"),
                          onTap: () async {
                            await launch(videos[index]["url"]);
                          },
                        ),
                      );
                    }),
              )
            ])),
          )
        ],
      ),
    );
  }
}
