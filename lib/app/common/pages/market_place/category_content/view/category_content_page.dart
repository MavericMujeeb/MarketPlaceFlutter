import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/category_content/controller/category_content_controller.dart';
import 'package:marketplace/app/common/pages/market_place/category_content/view/phone/category_content_phone_page.dart';
import 'package:marketplace/data/repositories/data_dashboard_repository.dart';

class CategoryContentPage extends View {
  final String title;

  const CategoryContentPage(Key? key, this.title) : super(key: key);

  @override
  CategoryContentPageState createState() => CategoryContentPageState();
}

class CategoryContentPageState extends ResponsiveViewState<CategoryContentPage, CategoryContentController> {
  CategoryContentPageState(): super(CategoryContentController(DataDashboardRepository()));

  @override
  Widget get desktopView => CategoryContentPhonePage(title: widget.title);

  @override
  Widget get mobileView => CategoryContentPhonePage(title: widget.title);

  @override
  Widget get tabletView => CategoryContentPhonePage(title: widget.title);

  @override
  Widget get watchView =>  CategoryContentPhonePage(title: widget.title);
}
