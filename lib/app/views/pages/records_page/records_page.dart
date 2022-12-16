import 'package:flutter/material.dart';

class FoodRecordsPage extends StatefulWidget {
  const FoodRecordsPage({super.key});

  @override
  State<FoodRecordsPage> createState() => _FoodRecordsPageState();
}

class _FoodRecordsPageState extends State<FoodRecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Records"),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.search))
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
