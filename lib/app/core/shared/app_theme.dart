import 'package:flutter/material.dart';
import 'package:konsi_test/app/core/common/constants/app_colors.dart';
import 'package:konsi_test/app/core/common/constants/app_fonts.dart';
import 'package:konsi_test/app/core/common/extensions/color_extension.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    fontFamily: AppFonts.defaultFont,
    primarySwatch: AppColors.primary.toMaterialColor(),
    splashColor: AppColors.primary.withOpacity(0.2),
    highlightColor: AppColors.primary.withOpacity(0.2),
    scaffoldBackgroundColor: AppColors.grey_50,
    canvasColor: AppColors.white,
    primaryColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: AppFonts.bold,
        color: AppColors.grey_950,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      overlayColor: AppColors.primary.withOpacity(0.2).toWidgetStateProperty(),
      indicatorColor: AppColors.cyan_100,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) => states.contains(WidgetState.selected)
            ? const TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: AppFonts.semiBold,
              )
            : const TextStyle(
                color: AppColors.grey_500,
                fontSize: 12,
                fontWeight: AppFonts.semiBold,
              ),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionHandleColor: AppColors.primary,
      cursorColor: AppColors.primary,
      selectionColor: AppColors.primary.withOpacity(0.2),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: AppFonts.bold,
        color: AppColors.grey_950,
      ),
      titleMedium: TextStyle(
        fontSize: 24,
        fontWeight: AppFonts.semiBold,
        color: AppColors.grey_900,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: AppFonts.semiBold,
        color: AppColors.grey_950,
      ),
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: AppFonts.semiBold,
        color: AppColors.grey_900,
      ), //EM BOTOES
      bodySmall: TextStyle(
        fontSize: 16,
        fontWeight: AppFonts.medium,
        color: AppColors.grey_600,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: AppFonts.medium,
        color: AppColors.grey_600,
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      primaryContainer: AppColors.grey_50,
      secondaryContainer: AppColors.white,
      surface: AppColors.white,
      tertiaryContainer: AppColors.grey_100,
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: false,
      prefixIconColor: AppColors.grey_300,
      labelStyle: const TextStyle(
        color: AppColors.grey_500,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),

      hintStyle: const TextStyle(
        color: AppColors.grey_300,
        fontSize: 16,
        fontWeight: AppFonts.medium,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
          strokeAlign: 1.0,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 0,
          color: Colors.transparent,
          strokeAlign: 1.0,
        ),
      ),
      //DISABLE  ------
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 0,
          color: Colors.transparent,
          strokeAlign: 1.0,
        ),
      ),
      //ERROR  ------
      errorStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.red_400.withOpacity(0.5),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.red_400,
          strokeAlign: 1.0,
        ),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 2,
          color: AppColors.red_400,
          strokeAlign: 1.0,
        ),
      ),
    ),
  ).copyWith(
    canvasColor: AppColors.grey_200,
    primaryColor: AppColors.grey_200,
  );
}
