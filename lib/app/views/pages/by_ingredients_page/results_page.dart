import 'package:flutter/material.dart';

import 'package:food_track_app/app/views/pages/details_page/details_page.dart';
import 'package:food_track_app/app/views/widgets/food_tile.dart';

class ResultPages extends StatefulWidget {
  const ResultPages({super.key});

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
