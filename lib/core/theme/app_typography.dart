import 'package:flutter/material.dart';

class AppTypography {
  // HEADINGS - Hanken Grotesk
  static const TextStyle headlineXL = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 48 / 40,
    letterSpacing: -0.02,
  );

  static const TextStyle headlineLG = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 32,
    fontWeight: FontWeight.w600,
    height: 40 / 32,
    letterSpacing: -0.01,
  );

  static const TextStyle headlineLGMobile = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
  );

  static const TextStyle titleMD = TextStyle(
    fontFamily: 'Hanken Grotesk',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
  );

  // BODY - Inter
  static const TextStyle bodyLG = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 28 / 18,
  );

  static const TextStyle bodyMD = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );

  static const TextStyle labelMD = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0.01,
  );

  static const TextStyle labelSM = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 16 / 12,
    letterSpacing: 0.05,
  );
}