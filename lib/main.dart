import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/navigation/router.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/view/dashboard_page.dart';
import 'package:marketplace/app/common/pages/market_place/login/login_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/my_apps_page.dart';
import 'package:marketplace/app/theme/themes/theme_dark.dart';
import 'package:marketplace/app/theme/themes/theme_light.dart';

void main() async{
  runApp(MarketPlaceApp());
}

class MarketPlaceApp extends StatelessWidget {
  final GlobalRouter _router;

  MarketPlaceApp({Key? key})
      : _router = GlobalRouter(),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      // home: DashboardPage(title: "title", selectedTabIndex: 0),
      home: const LoginPage(),
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}
