import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_track_app/app/views/theme/colors.dart';

class AppThemeSchema {
  static ThemeData light =
      ThemeData.from(colorScheme: AppColorSchema.flexSchemeLight).copyWith(
    typography: Typography.material2018(platform: defaultTargetPlatform),
  );
  static ThemeData dark =
      ThemeData.from(colorScheme: AppColorSchema.flexSchemeDark).copyWith(
    typography: Typography.material2018(platform: defaultTargetPlatform),
  );
}
