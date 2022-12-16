import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/by_ingredients_page/food_by_ingr_page.dart';

class ResultPages extends StatefulWidget {
  const ResultPages({super.key, required this.query});

  final Query query;
  @override
  State<ResultPages> createState() => _ResultPagesState();
}

class _ResultPagesState extends State<ResultPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(),
        ),
      ),
    );
  }
}
