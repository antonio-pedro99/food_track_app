import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/driver.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageDriver(title: 'Flutter Demo Home Page'),
    );
  }
}
