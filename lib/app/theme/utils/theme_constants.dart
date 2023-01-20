import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';

class ThemeColors {
  static const Color primary_color = AppColor.primary_color;
  static const Color button_disabled_color = AppColor.disabled_color;
  static const Color button_enabled_color = primary_color;
  static const Color span_text_color = AppColor.blue_color;
  static const Color media_button_arrow_color = AppColor.black_color;
  static const Color media_button_background_color = AppColor.white_color;
  static const Color media_button_text_color = AppColor.black_color;
  static const Color media_button_border_color = AppColor.black_color;
  static const Color bottom_nav_unselected_color = AppColor.grey_color;

  static const MaterialColor primary_material_color = MaterialColor(
    0xFFFE3E4C,
    <int, Color>{
      50: primary_color,
      100: primary_color,
      200: primary_color,
      300: primary_color,
      400: primary_color,
      500: primary_color,
      600: primary_color,
      700: primary_color,
      900: primary_color,
      800: primary_color,
    },
  );
}

class ThemeColorsLight {
  static const Color tab_bar_selected_text_color = AppColor.black_color;
  static const Color tab_bar_unselected_text_color = AppColor.black_color_54;
  static const Color text_field_text_color = AppColor.black_color_87;
  static const Color text_field_hint_color = AppColor.black_color_87;
  static const Color text_field_label_color = AppColor.black_color_87;
  static const Color text_field_underline_border_color = AppColor.black_color;
}

class ThemeColorsDark {
  static const Color text_field_text_color = AppColor.black_color_87;
  static const Color text_field_hint_color = AppColor.white_color_70;
  static const Color text_field_label_color = AppColor.white_color_70;
  static const Color text_field_underline_border_color = AppColor.white_color;
}

class ThemeDimensions {
  static const double button_height = 50.0;
  static const double text_field_label_size = 14.0;
  static const double text_field_hint_size = 15.0;
  static const double text_field_underline_border_width = 0.5;
}
