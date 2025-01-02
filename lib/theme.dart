import 'package:flutter/material.dart';
import 'package:usemain/providers/config.dart';
import 'package:usemain/shares/colors.dart';

ThemeData initTheme(ConfigProvider provider) {
  ThemeData isTheme = provider.isLight ? ThemeData.light() : ThemeData.dark();
  Color isPrimary = provider.isLight ? Colors.black : Colors.white;

  return isTheme.copyWith(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    shadowColor: Colors.transparent,
    hintColor: Colors.transparent,
    disabledColor: Colors.transparent,
    cardColor: Colors.transparent,
    primaryColor: commonColor,
    canvasColor: isThemeBgColor(provider),
    dialogBackgroundColor: isThemeBgColor(provider),
    scaffoldBackgroundColor: isThemeBgColor(provider),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: provider.isLight
            ? const Color.fromARGB(255, 166, 166, 166)
            : const Color.fromARGB(255, 99, 99, 99),
      ),
    ),
    colorScheme: (provider.isLight
            ? const ColorScheme.light()
            : const ColorScheme.dark())
        .copyWith(
      primary: commonColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: isThemePopupBgColor(provider),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: isThemeBgColor(provider),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),
    appBarTheme: AppBarTheme(
      toolbarHeight: 55,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isThemeBgColor(provider),
      titleTextStyle: TextStyle(
        fontSize: 19,
        color: isPrimary,
      ),
      iconTheme: IconThemeData(
        size: 20,
        color: isPrimary,
        shadows: const [
          Shadow(
            color: Colors.transparent,
            blurRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
    ),
  );
}
