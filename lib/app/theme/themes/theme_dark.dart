import 'package:flutter/material.dart';
import 'package:marketplace/app/theme/utils/theme_constants.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  indicatorColor: ThemeColors.primary_color,
  toggleableActiveColor: ThemeColors.primary_color,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    hintStyle: TextStyle(
      color: ThemeColorsDark.text_field_hint_color,
      fontSize: ThemeDimensions.text_field_hint_size,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: ThemeColorsDark.text_field_label_color,
      fontSize: ThemeDimensions.text_field_label_size,
      fontWeight: FontWeight.normal,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColorsDark.text_field_underline_border_color,
        width: ThemeDimensions.text_field_underline_border_width,
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    height: ThemeDimensions.button_height,
    buttonColor: ThemeColors.button_enabled_color,
    disabledColor: ThemeColors.button_disabled_color,
  ),
);
