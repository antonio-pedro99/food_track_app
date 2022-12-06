import 'package:flutter/material.dart';

class FoodByIngridPage extends StatefulWidget {
  const FoodByIngridPage({super.key, required this.title});

  final String title;

  @override
  State<FoodByIngridPage> createState() => _FoodByIngridPageState();
}

class _FoodByIngridPageState extends State<FoodByIngridPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              "Hello World",
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
