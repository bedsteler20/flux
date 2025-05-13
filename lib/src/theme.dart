import 'package:flutter/material.dart';

ThemeData generateFluxTheme() {
  const pink = Color(0xFFcba6f7);
  const text = Color(0xFFcdd6f4);
  const red = Color(0xFFf38ba8);
  const base = Color(0xFF1e1e2e);
  const mantle = Color(0xFF181825);
  const purple = Color(0xFFcba6f7);
  const darkText = Color(0xFF1e1e2e);
  const crust = Color(0xFF11111b);
  const buttonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    )),
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: base,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: pink,
      onPrimary: darkText,
      secondary: purple,
      onSecondary: darkText,
      error: red,
      onError: darkText,
      surface: mantle,
      onSurface: text,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: mantle,
      foregroundColor: text,
      elevation: 0,
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    filledButtonTheme: const FilledButtonThemeData(
      style: buttonStyle,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: buttonStyle,
    ),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: buttonStyle,
    ),
    menuTheme: const MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(crust),
        visualDensity: VisualDensity.comfortable,
        shadowColor: WidgetStatePropertyAll(darkText),
        alignment: AlignmentDirectional.center,
      ),
    ),
    menuButtonTheme: const MenuButtonThemeData(
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(150, 40)),
        visualDensity: VisualDensity.comfortable,
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        )),
      ),
    ),
  );
}
