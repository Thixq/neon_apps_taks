import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// The theme for the app.
final class NeonTheme {
  const NeonTheme._();

  /// The filled button theme for the app.
  static FilledButtonThemeData get filledButtonTheme => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: AppSizes.mediumBorderRadius),
    ),
  );

  /// The dark theme for the app.
  static ThemeData dark() => ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color(0XFFFFF085),
    ),
    filledButtonTheme: filledButtonTheme,
  );

  /// The light theme for the app.
  static ThemeData light() => ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFFFFF085)),
    filledButtonTheme: filledButtonTheme,
  );
}
