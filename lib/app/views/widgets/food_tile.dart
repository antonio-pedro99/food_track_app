import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/food.dart';
import 'package:food_track_app/app/models/food_info.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, this.food, this.foodByIngredient});

  final Food? food;
  final FoodByIngredient? foodByIngredient;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl:
                      food == null ? foodByIngredient!.image : food!.image,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                )
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food == null ? foodByIngredient!.title : food!.label,
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 8),
                food == null
                    ? Container()
                    : Text(
                        food!.knownAs,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.black.withOpacity(.6)),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
