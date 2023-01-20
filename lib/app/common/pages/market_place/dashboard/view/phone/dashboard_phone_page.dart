import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/browse/view/browse_page.dart';
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

class DashboardPhonePage extends View {
  final String title;
  int selectedTabIndex = 0;

  DashboardPhonePage({Key? key, required this.title, required this.selectedTabIndex}) : super(key: key);

  @override
  DashboardPhonePageView createState() => DashboardPhonePageView();
}

class DashboardPhonePageView extends ViewState<DashboardPhonePage, DashboardController> {
  DashboardPhonePageView() : super(DashboardController(DataDashboardRepository()));

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
                  /*Material(
                    child: searchBar,
                    color: AppColor.black_color,
                  ),*/
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
                                          backgroundColor: AppColor.black_color,
                                          bottom: TabBar(
                                            onTap: (index) {
                                              widget.selectedTabIndex = index;
                                            },
                                            labelColor: AppColor.white_color,
                                            isScrollable: false,
                                            unselectedLabelColor: AppColor.white_color,
                                            indicatorColor: AppColor.white_color,
                                            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
                                            tabs: [
                                              Tab(
                                                child: CustomText(
                                                  textName: Constants.home,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              Tab(
                                                child: CustomText(
                                                  textName: Constants.my_apps,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              /*Tab(
                                                child: CustomText(
                                                  textName: Constants.preferences,
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),*/
                                            ],
                                          ),
                                        ),
                                        key: globalKey,
                                        body: TabBarView(
                                          // controller: tabController,
                                          children: [
                                            HomePage(title: '', selectedTabIndex: 0),
                                            const MyAppsPage(),
                                            // const BrowsePage(null, ''),
                                          ],
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
