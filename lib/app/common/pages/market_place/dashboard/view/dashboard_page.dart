import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/controller/dashboard_controller.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/view/phone/dashboard_phone_page.dart';
import 'package:marketplace/data/repositories/data_dashboard_repository.dart';

class DashboardPage extends View {
  final String title;
  int selectedTabIndex = 0;

  DashboardPage({Key? key, required this.title, required this.selectedTabIndex}) : super(key: key);

  @override
  DashboardPageView createState() => DashboardPageView();
}

class DashboardPageView extends ResponsiveViewState<DashboardPage, DashboardController>{
  DashboardPageView() : super(DashboardController(DataDashboardRepository()));

  @override
  Widget get desktopView => DashboardPhonePage(title: '', selectedTabIndex: widget.selectedTabIndex);

  @override
  Widget get mobileView => DashboardPhonePage(title: '', selectedTabIndex:widget.selectedTabIndex);

  @override
  Widget get tabletView => DashboardPhonePage(title: '', selectedTabIndex:widget.selectedTabIndex);

  @override
  Widget get watchView =>  DashboardPhonePage(title: '', selectedTabIndex:widget.selectedTabIndex);

}
