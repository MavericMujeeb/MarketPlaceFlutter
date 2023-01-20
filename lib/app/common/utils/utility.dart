import 'package:flutter/material.dart';

class ResponsiveScreen {
  static const int largeScreen = 1200;
  static const int smallScreen = 800;

  //Small screen is any screen whose width is less than 800 pixels
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallScreen;
  }

  //Medium screen is any screen whose width is less than 1200 pixels,
  //and more than 800 pixels
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > smallScreen &&
        MediaQuery.of(context).size.width < largeScreen;
  }

  //Large screen is any screen whose width is more than 1200 pixels
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreen;
  }
}
