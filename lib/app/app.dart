import 'package:flutter/material.dart';
import 'package:food_track_app/app/providers/food_provider.dart';
import 'package:food_track_app/app/views/pages/driver.dart';
import 'package:food_track_app/app/views/theme/theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
      ],
      child: MaterialApp(
        title: 'Food Track',
        theme: AppThemeSchema.light,
        darkTheme: AppThemeSchema.dark,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        home: StreamBuilder(
          builder: (ctx, userSnapShot) {
            return const PageDriver();
          },
        ),
      ),
    );
  }
}
