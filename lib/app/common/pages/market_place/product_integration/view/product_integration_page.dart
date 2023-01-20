import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/market_place/product_integration/controller/product_integration_controller.dart';
import 'package:marketplace/app/common/pages/market_place/product_integration/view/phone/product_integration_phone_page.dart';

class ProductIntegrationPage extends View{

  const ProductIntegrationPage(Key? key) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return AppIntegrationViewState();
  }
}

class AppIntegrationViewState extends ResponsiveViewState<ProductIntegrationPage, ProductIntegrationController>{

  AppIntegrationViewState(): super(ProductIntegrationController(null));

  @override
  Widget get desktopView => const ProductIntegrationPhoneView();

  @override
  Widget get mobileView =>  const ProductIntegrationPhoneView();

  @override
  Widget get tabletView => const ProductIntegrationPhoneView();

  @override
  Widget get watchView => throw UnimplementedError();
}