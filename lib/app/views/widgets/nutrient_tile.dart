import 'package:flutter/material.dart';
import 'dart:math';

class NutrientTile extends StatelessWidget {
  const NutrientTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Cal: ',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black.withOpacity(.6)),
        ),
        Text(
          '${Random().nextInt(100)} k',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 8),
        Text(
          'Sug: ',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black.withOpacity(.6)),
        ),
        Text(
          '${Random().nextInt(100)} g',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 8),
        Text(
          'Carbs: ',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black.withOpacity(.6)),
        ),
        Text(
          '${Random().nextInt(100)} g',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 8),
        Text(
          'Prot: ',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black.withOpacity(.6)),
        ),
        Text(
          '${Random().nextInt(100)} g',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 8),
        Text(
          'Fat: ',
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black.withOpacity(.6)),
        ),
        Text(
          '${Random().nextInt(100)} g',
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: Colors.black.withOpacity(.6),
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
