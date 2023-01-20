import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/home/controller/home_controller.dart';
import 'package:marketplace/app/common/pages/market_place/home/view/phone/home_phone_page.dart';
import 'package:marketplace/data/repositories/data_dashboard_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends View {
  final String title;
  int selectedTabIndex = 0;

  HomePage({Key? key, required this.title, required this.selectedTabIndex}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ResponsiveViewState<HomePage, HomeController> {
  HomePageState() : super(HomeController(DataDashboardRepository()));

  @override
  Widget get desktopView => HomePhonePage();

  @override
  Widget get mobileView => HomePhonePage();

  @override
  Widget get tabletView => HomePhonePage();

  @override
  Widget get watchView =>  HomePhonePage();
}