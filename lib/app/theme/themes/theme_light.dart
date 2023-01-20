import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/theme/utils/theme_constants.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColor.grey_color_100,
  toggleableActiveColor: ThemeColors.primary_color,
  indicatorColor: ThemeColors.primary_color,
  primaryTextTheme: const TextTheme(
    headline6: TextStyle(
      color: AppColor.black_color,
    ),
  ),
  appBarTheme: const AppBarTheme(
    color: AppColor.white_color,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: AppColor.black_color,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    hintStyle: TextStyle(
      color: ThemeColorsLight.text_field_hint_color,
      fontSize: ThemeDimensions.text_field_hint_size,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: ThemeColorsLight.text_field_label_color,
      fontSize: ThemeDimensions.text_field_label_size,
      fontWeight: FontWeight.normal,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: ThemeColorsLight.text_field_underline_border_color,
        width: ThemeDimensions.text_field_underline_border_width,
      ),
    ),
  ),
  buttonTheme: const ButtonThemeData(
    height: ThemeDimensions.button_height,
    buttonColor: ThemeColors.button_enabled_color,
    disabledColor: ThemeColors.button_disabled_color,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: ThemeColorsLight.tab_bar_selected_text_color,
    labelStyle: TextStyle(
      color: ThemeColorsLight.tab_bar_selected_text_color,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelColor: ThemeColorsLight.tab_bar_unselected_text_color,
    unselectedLabelStyle: TextStyle(
      color: ThemeColorsLight.tab_bar_unselected_text_color,
      fontWeight: FontWeight.normal,
    ),
  ),
);
