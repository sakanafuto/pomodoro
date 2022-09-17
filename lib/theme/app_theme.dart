import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static ThemeData mainThemeData = themeData(lightColorScheme, textTheme);

  static ThemeData themeData(ColorScheme colorScheme, TextTheme textTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.secondaryContainer,
        titleTextStyle: TextStyle(color: colorScheme.secondary),
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.secondaryContainer,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.tertiary,
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: colorScheme.primary.withOpacity(0.2),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF001a1d),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFBFE8FF),
    onPrimaryContainer: Color(0xFF001F2A),
    secondary: Color(0xFF526069),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD5E5EF),
    onSecondaryContainer: Color(0xFF0F1D24),
    tertiary: Color(0xFF5E5B76),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE4DFFF),
    onTertiaryContainer: Color(0xFF1B1930),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFCFD),
    surface: Color(0xFFFCFCFD),
    onBackground: Color(0xFF1A1C1D),
    onSurface: Color(0xFF1A1C1D),
    surfaceVariant: Color(0xFF1A1C1D),
    onSurfaceVariant: Color(0xFF42484B),
    outline: Color(0xFF72787C),
  );

  static final TextTheme textTheme = TextTheme(
    headline1:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w700, fontSize: 24.0),
    headline2:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w700, fontSize: 22.0),
    headline3:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w700, fontSize: 20.0),
    headline4:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 18.0),
    headline5:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 16.0),
    headline6:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 16.0),
    bodyText1:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w400, fontSize: 14.0),
    bodyText2:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w400, fontSize: 16.0),
    subtitle1:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 16.0),
    subtitle2:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 14.0),
    caption:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w600, fontSize: 14.0),
    button:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w600, fontSize: 14.0),
    overline:
        GoogleFonts.sawarabiGothic(fontWeight: FontWeight.w500, fontSize: 12.0),
  );
}
