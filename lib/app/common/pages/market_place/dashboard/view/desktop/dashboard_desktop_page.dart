import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/controller/dashboard_controller.dart';
import 'package:marketplace/app/common/pages/market_place/home/view/home_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/my_apps_page.dart';
import 'package:marketplace/app/common/pages/market_place/search/view/search_page.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_search.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/repositories/data_dashboard_repository.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

enum ViewType { search, dashboard }

class DashboardDesktopPage extends View {
  final String title;
  int selectedTabIndex = 0;

  DashboardDesktopPage({Key? key, required this.title, required this.selectedTabIndex}) : super(key: key);

  @override
  DashboardDesktopPageView createState() => DashboardDesktopPageView();
}

class DashboardDesktopPageView extends ViewState<DashboardDesktopPage, DashboardController> {
  DashboardDesktopPageView() : super(DashboardController(DataDashboardRepository()));

  //default tab index
  DashboardController? dashboardController;
  ViewType viewType = ViewType.dashboard;

  /*
   * Search bar widget to perform search action for market place apps.
   */
  String? searchPattern;
  TextEditingController? searchTextController;
  FocusNode? searchTextFocusNode;

  @override
  Widget get view => Material(
    child: ControlledWidgetBuilder<DashboardController>(
      builder: (buildContext, controller) {
        dashboardController = controller;
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                child: searchBar,
              ),
              viewType == ViewType.search
                  ? searchResults(controller)
                  : Expanded(
                child: DefaultTabController(
                  initialIndex: widget.selectedTabIndex,
                  length: 2,
                  child: FutureBuilder(
                    future: loadTabs(),
                    builder: (buildContext, snapShot) {
                      return snapShot.hasData
                          ? Scaffold(
                        appBar: AppBar(
                          elevation: 0,
                          toolbarHeight: 0,
                          backgroundColor: AppColor.transparent_color,
                          bottom: TabBar(
                            onTap: (index) {
                              widget.selectedTabIndex = index;
                            },
                            labelColor: AppColor.blue_color,
                            isScrollable: false,
                            unselectedLabelColor: AppColor.black_color,
                            indicatorColor: AppColor.blue_color,
                            tabs: [
                              Tab(
                                child: CustomText(
                                  textName: Constants.home,
                                  textAlign: TextAlign.center,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Tab(
                                child: CustomText(
                                  textName: Constants.my_apps,
                                  textAlign: TextAlign.center,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        key: globalKey,
                        body: TabBarView(
                          // controller: tabController,
                          children: [HomePage(title:'', selectedTabIndex: 0), const MyAppsPage()],
                        ),
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    ),
  );

  loadTabs() async {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return true;
    });
  }

  Widget get searchBar => ControlledWidgetBuilder<DashboardController>(builder: (context, DashboardController controller) {
    return CustomSearch(
      null,
      searchOptions: const [
        {'name': 'Addepar'}
      ],
      onSearchStarted: (String value, TextEditingController controller, FocusNode focusNode) {
        searchTextController = controller;
        searchTextFocusNode = focusNode;
        searchPattern = value;
        if (value.isNotEmpty) {
          viewType = ViewType.search;
        } else {
          viewType = ViewType.dashboard;
        }
        dashboardController?.refresh();
      },
    );
  });

  /*
   * Widget to display search results.
   */
  Widget searchResults(DashboardController controller) => FutureBuilder(
    builder: (buildContext, snapShot) {
      detailCallBack() {
        searchTextController?.text = "";
        searchTextFocusNode?.unfocus();
        viewType = ViewType.dashboard;
        dashboardController?.refresh();
      }

      if (snapShot.hasData) {
        var data = snapShot.data;
        List<ProductDao> results = [];
        if (data is List) {
          for (ProductDao entry in data) {
            results.add(entry);
          }
        }
        return SearchResultsView(null, results, detailCallBack);
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
    future: controller.performSearch(searchPattern),
  );
}
