import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_track_app/app/models/ingredient.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({super.key, required this.ingredient});

  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: ingredient.image!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ingredient.text!,
                    maxLines: 1,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16)),
                const SizedBox(height: 6),
                Text(ingredient.foodCategory!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Colors.black.withOpacity(.8),
                        overflow: TextOverflow.fade)),
                const SizedBox(height: 6),
                Text(
                  "Measure: ${ingredient.measure}",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
