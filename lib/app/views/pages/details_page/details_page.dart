import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/details_page/carousel.dart';
import 'package:food_track_app/app/views/widgets/nutrient_tile.dart';

class FoodDetailsPage extends StatefulWidget {
  const FoodDetailsPage({super.key, required this.title, this.tag});
  final String title;
  final String? tag;
  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
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
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: kToolbarHeight, left: 8, right: 8),
                  child: Hero(
                    tag: widget.tag!,
                    child: CustomCarouselSlider(itemCount: 2, items: [
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.blue,
                        height: 200,
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              Text(
                'Chicken Masala',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              const NutrientTile(),
              const SizedBox(height: 24),
              Text(
                'Recipes',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Container(
                height: 300,
                child: ListView(),
              )
            ])),
          )
        ],
      ),
    );
  }
}
