import 'package:flutter/material.dart';
import 'package:marketplace/app/common/navigation/pages.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/view/acs_chat_calling_page.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/view/dashboard_page.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/view/phone/product_details_phone_page.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/view/product_detail_page.dart';
import 'package:marketplace/app/common/pages/market_place/product_integration/view/product_integration_page.dart';
import 'package:marketplace/app/widgets/custom_status_screeen.dart';
import 'package:marketplace/data/repositories/data_product_repository.dart';

class GlobalRouter {
  final RouteObserver<PageRoute> routeObserver;

  GlobalRouter() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.screen_product_detail:
        return _buildRoute(settings, const ProductDetailsPage());
      case Pages.screen_product_integration_process:
        return _buildRoute(settings, const ProductIntegrationPage(null));
      case Pages.screen_market_place:
        return _buildRoute(settings, DashboardPage(title: '', selectedTabIndex: 0,));
      case Pages.screen_contact_center:
        return _buildRoute(settings, ACSChatCallingPage());
      default:
        return _buildRoute(settings, DashboardPage(title: '', selectedTabIndex: 0,));
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
