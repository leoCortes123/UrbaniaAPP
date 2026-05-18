import 'package:flutter/material.dart';

class AppColors {
  // Surface Tints - Sistema de tonalidades basadas en primary
  static const Color surface = Color(0xFFF8F9FF);
  static const Color surfaceDim = Color(0xFFCBDBF5);
  static const Color surfaceBright = Color(0xFFF8F9FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color surfaceContainerHighest = Color(0xFFD3E4FE);
  static const Color surfaceVariant = Color(0xFFD3E4FE);
  static const Color surfaceTint = Color(0xFF415F8F);

  // On Surface
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color onSurfaceVariant = Color(0xFF43474F);
  static const Color inverseSurface = Color(0xFF213145);
  static const Color inverseOnSurface = Color(0xFFEAF1FF);

  // Outline
  static const Color outline = Color(0xFF747780);
  static const Color outlineVariant = Color(0xFFC4C6D0);

  // Primary - Deep Navy (#002855)
  static const Color primary = Color(0xFF001430);
  static const Color primaryContainer = Color(0xFF002855);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF7490C3);
  static const Color inversePrimary = Color(0xFFAAC7FD);

  // Primary Fixed
  static const Color primaryFixed = Color(0xFFD6E3FF);
  static const Color primaryFixedDim = Color(0xFFAAC7FD);
  static const Color onPrimaryFixed = Color(0xFF001B3D);
  static const Color onPrimaryFixedVariant = Color(0xFF284775);

  // Secondary - Vibrant Green (#4CAF50)
  static const Color secondary = Color(0xFF006E1C);
  static const Color secondaryContainer = Color(0xFF91F78E);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF00731E);

  // Secondary Fixed
  static const Color secondaryFixed = Color(0xFF94F990);
  static const Color secondaryFixedDim = Color(0xFF78DC77);
  static const Color onSecondaryFixed = Color(0xFF002204);
  static const Color onSecondaryFixedVariant = Color(0xFF005313);

  // Tertiary
  static const Color tertiary = Color(0xFF101517);
  static const Color tertiaryContainer = Color(0xFF24292C);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFF8B9094);

  // Tertiary Fixed
  static const Color tertiaryFixed = Color(0xFFDFE3E7);
  static const Color tertiaryFixedDim = Color(0xFFC3C7CB);
  static const Color onTertiaryFixed = Color(0xFF171C1F);
  static const Color onTertiaryFixedVariant = Color(0xFF43474B);

  // Error
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Background
  static const Color background = Color(0xFFF8F9FF);
  static const Color onBackground = Color(0xFF0B1C30);

  // Semantic Colors for Alerts
  static const Color success = secondary;
  static const Color successContainer = secondaryContainer;
  static const Color onSuccess = onSecondary;
  static const Color onSuccessContainer = onSecondaryContainer;

  static const Color warning = Color(0xFFB8860B);
  static const Color warningContainer = Color(0xFFFFF8DC);
  static const Color onWarning = Color(0xFF000000);
  static const Color onWarningContainer = Color(0xFF5C4033);

  static const Color info = primaryContainer;
  static const Color infoContainer = primaryFixed;
  static const Color onInfo = onPrimaryContainer;
  static const Color onInfoContainer = onPrimaryFixed;
}

class AppSemanticColors {
  static const Color success = AppColors.secondary;
  static const Color successContainer = AppColors.secondaryContainer;
  static const Color onSuccess = AppColors.onSecondary;
  static const Color onSuccessContainer = AppColors.onSecondaryContainer;

  static const Color warning = Color(0xFFB8860B);
  static const Color warningContainer = Color(0xFFFFF8DC);
  static const Color onWarning = Color(0xFF000000);
  static const Color onWarningContainer = Color(0xFF5C4033);

  static const Color info = AppColors.primaryContainer;
  static const Color infoContainer = AppColors.primaryFixed;
  static const Color onInfo = AppColors.onPrimaryContainer;
  static const Color onInfoContainer = AppColors.onPrimaryFixed;

  static const Color errorBackground = AppColors.errorContainer;
}