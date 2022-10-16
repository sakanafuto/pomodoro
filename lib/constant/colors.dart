// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

ThemeData pomoTheme(ColorScheme shaftColorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: shaftColorScheme,
    textTheme: textTheme,
  );
}

const workColorScheme = WorkColorScheme();
const restColorScheme = RestColorScheme();
const hobyColorScheme = HobyColorScheme();

class WorkColorScheme extends ColorScheme {
  const WorkColorScheme() : super.light();

  @override
  Color get primaryContainer => const Color(0xFF008DB9);

  @override
  Color get secondaryContainer => const Color(0xFFD1D7DA);

  @override
  Color get background => const Color(0xFFFFFFFD);
}

class RestColorScheme extends ColorScheme {
  const RestColorScheme() : super.light();

  @override
  Color get primaryContainer => const Color(0xFF006F00);
}

class HobyColorScheme extends ColorScheme {
  const HobyColorScheme() : super.light();

  @override
  Color get primaryContainer => const Color(0xFFB9005A);

  @override
  Color get background => const Color(0xFFFFE8F3);
}

TextStyle mainFonts(FontWeight weight, double size) {
  return GoogleFonts.sawarabiGothic(fontWeight: weight, fontSize: size);
}

final TextTheme textTheme = TextTheme(
  headline1: mainFonts(FontWeight.w700, 24),
  headline2: mainFonts(FontWeight.w700, 22),
  headline3: mainFonts(FontWeight.w700, 20),
  headline4: mainFonts(FontWeight.w500, 18),
  headline5: mainFonts(FontWeight.w500, 16),
  headline6: mainFonts(FontWeight.w500, 16),
  bodyText1: mainFonts(FontWeight.w400, 14),
  bodyText2: mainFonts(FontWeight.w400, 16),
  subtitle1: mainFonts(FontWeight.w500, 16),
  subtitle2: mainFonts(FontWeight.w500, 14),
  caption: mainFonts(FontWeight.w600, 14),
  button: mainFonts(FontWeight.w600, 14),
  overline: mainFonts(FontWeight.w500, 12),
);
