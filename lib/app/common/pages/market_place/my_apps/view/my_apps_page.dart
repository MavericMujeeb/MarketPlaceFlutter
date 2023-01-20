import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/controller/my_apps_controller.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/phone/my_apps_phone_page.dart';
import 'package:flutter/material.dart';


class MyAppsPage extends View{
  const MyAppsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyAppsPhonePageState(MyAppsController(MyAppsRepository()));
  }
}

class MyAppsPhonePageState extends ResponsiveViewState{

  MyAppsPhonePageState(super.controller);

  @override
  Widget get desktopView => MyAppsPhonePage();

  @override
  Widget get mobileView => MyAppsPhonePage();

  @override
  Widget get tabletView => MyAppsPhonePage();

  @override
  Widget get watchView => MyAppsPhonePage();

}