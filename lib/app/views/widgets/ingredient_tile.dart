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
          Container(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: Image.network(
                ingredient.image!,
                fit: BoxFit.fitWidth,
                height: 150,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ingredient.text!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  ingredient.food!,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black.withOpacity(.8)),
                ),
                const SizedBox(height: 16),
                Text(
                  "Measure: ${ingredient.measure}",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
