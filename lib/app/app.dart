// ignore_for_file: unused_import, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/pages/driver.dart';
import 'package:food_track_app/app/views/theme/theme.dart';
import 'package:provider/provider.dart';

import '../providers/api_details.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: API_Details(),
        ),
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
        // routes: {},
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Food Track',
//       theme: AppThemeSchema.light,
//       darkTheme: AppThemeSchema.dark,
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       home: const PageDriver(),
//     );
//   }
// }
