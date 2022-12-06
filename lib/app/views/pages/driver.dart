import 'package:flutter/material.dart';

class PageDriver extends StatefulWidget {
  const PageDriver({super.key, required this.title});

  final String title;

  @override
  State<PageDriver> createState() => _PageDriverState();
}

class _PageDriverState extends State<PageDriver> {
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
