import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/search/controller/search_controller.dart';
import 'package:marketplace/app/common/pages/market_place/search/view/phone/search_phone_page.dart';
import 'package:marketplace/domain/entities/product_dao.dart';


class SearchResultsView extends View{
  final List<ProductDao> results;
  Function? detailActionCallBack;

  SearchResultsView(Key? key, this.results, this.detailActionCallBack) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return SearchResultsViewState();
  }
}

class SearchResultsViewState extends ResponsiveViewState<SearchResultsView, SearchController>{

  SearchResultsViewState() : super(SearchController(null));

  @override
  Widget get mobileView => SearchPhonePage(null, widget.results, widget.detailActionCallBack);

  @override
  Widget get watchView => SearchPhonePage(null, widget.results, widget.detailActionCallBack);

  @override
  Widget get desktopView => SearchPhonePage(null, widget.results, widget.detailActionCallBack);

  @override
  Widget get tabletView => SearchPhonePage(null, widget.results, widget.detailActionCallBack);

}