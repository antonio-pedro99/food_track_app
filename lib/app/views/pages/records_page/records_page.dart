import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_track_app/app/models/food_info.dart';
import 'package:food_track_app/app/providers/food.dart';
import 'package:food_track_app/app/services/api.dart';
import 'package:food_track_app/app/views/pages/records_page/food_search_delegate.dart';

class FoodRecordPage extends ConsumerWidget {
  const FoodRecordPage({super.key});

  _showSearch(BuildContext context, WidgetRef ref) async {
    var foodsResult = [];

    FoodSearchService searchService = ref.read(searchServiceProvider);
    final searchDelegate = FoodSearchDelegate(searchService);
    showSearch(context: context, delegate: searchDelegate);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Records"),
        actions: [
          IconButton(
              onPressed: () => _showSearch(context, ref),
              icon: const Icon(Icons.search))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
