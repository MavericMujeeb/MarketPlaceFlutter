import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/browse/controller/browse_controller.dart';
import 'package:marketplace/app/common/pages/market_place/browse/view/phone/browse_phone_page.dart';

class BrowsePage extends View {
  final String title;

  const BrowsePage(Key? key, this.title) : super(key: key);

  @override
  BrowsePageState createState() => BrowsePageState();
}

class BrowsePageState extends ResponsiveViewState<BrowsePage, BrowseController> {
  BrowsePageState(): super(BrowseController(BrowseRepository()));

  @override
  Widget get desktopView => const BrowsePhonePage(title: '',);

  @override
  Widget get mobileView => const BrowsePhonePage(title: '',);

  @override
  Widget get tabletView => const BrowsePhonePage(title: '',);

  @override
  Widget get watchView =>  const BrowsePhonePage(title: '',);
}
