import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/driver.dart';
import 'package:food_track_app/app/views/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Food Track',
        theme: AppThemeSchema.light,
        darkTheme: AppThemeSchema.dark,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: const PageDriver());
  }
}
