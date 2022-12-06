import 'package:flutter/material.dart';

class FoodByNamePage extends StatefulWidget {
  const FoodByNamePage({super.key, required this.title});

  final String title;

  @override
  State<FoodByNamePage> createState() => _FoodByNamePageState();
}

class _FoodByNamePageState extends State<FoodByNamePage> {
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
