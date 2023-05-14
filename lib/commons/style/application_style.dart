import 'package:flutter/material.dart';
import 'package:paygo_app/commons/style/application_colors.dart';

enum StyleType {
  paygoLight,
  paygoDark,
}

class ApplicatioStyle {
  static ThemeData paygoLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: ApplicationColors.paygoDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: ApplicationColors.paygoDark,
      titleTextStyle: TextStyle(
        color: ApplicationColors.paygoWhite,
        fontSize: 20,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 22,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      labelMedium: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      displayLarge: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 22,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 22,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 22,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 22,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 18,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: ApplicationColors.paygoDark,
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ApplicationColors.paygoYellow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      colorScheme: const ColorScheme.light(
        primary: ApplicationColors.paygoDark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ApplicationColors.paygoYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          color: ApplicationColors.paygoDark,
          fontSize: 16,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );

  static ThemeData paygoDark = ThemeData(
    brightness: Brightness.dark,
  );

  static ThemeData getTheme(StyleType type) {
    return paygoLight;
  }
}
