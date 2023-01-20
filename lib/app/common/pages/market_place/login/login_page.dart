import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/market_place/login/controller/login_controller.dart';
import 'package:marketplace/app/common/pages/market_place/login/view/phone/login_phone_page.dart';
import 'package:marketplace/data/repositories/data_authentication_repository.dart';

class LoginPage extends View{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends ResponsiveViewState<LoginPage, LoginController>{

  LoginPageState() : super(LoginController(DataAuthenticationRepository()));

  @override
  Widget get desktopView => LoginPhonePage();

  @override
  Widget get mobileView => LoginPhonePage();

  @override
  Widget get tabletView => LoginPhonePage();

  @override
  Widget get watchView => LoginPhonePage();

}