import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/view/acs_chat_calling_page.dart';
import 'package:marketplace/app/common/pages/market_place/category_content/view/category_content_page.dart';
import 'package:marketplace/app/common/pages/market_place/home/controller/home_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_tab_bar.dart';
import 'package:marketplace/data/repositories/data_dashboard_repository.dart';

class HomePhonePage extends View {
  @override
  HomePhoneView createState() => HomePhoneView();
}

class HomePhoneView extends ViewState<HomePhonePage, HomeController> {
  HomePhoneView() : super(HomeController(DataDashboardRepository()));

  final List appCategories = [
    'All Apps',
    'Wealth Management Apps'
    /*'Tax Solutions',
    'Grow your wealth',
    'Accounting',*/
  ];

  @override
  Widget get view => Scaffold(
    appBar: AppBar(
      elevation: 0,
      toolbarHeight: 0,
      backgroundColor: AppColor.transparent_color,
    ),
    key: globalKey,
    body: SafeArea(
      child: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return dashboardBody;
        },
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        // Add your onPressed code here!
        Future.delayed(const Duration(microseconds: 500), () {
          navigateToContactCernterScreen(context);
        });
      },
      backgroundColor: Colors.blue,
      child: const Icon(Icons.call),
    ),
  );

  Widget get dashboardBody => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: marketplaceHomeContents,
    ),
  );

  /*
   * Widget to display market place home screen.
   */
  Widget get marketplaceHomeContents => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      logoWithTitle,
      marketPlaceTabs,
    ],
  );

  /*
   * Market place logo widget
   */
  Widget get logoWithTitle => Stack(
    alignment: Alignment.bottomLeft,
    children: [
      SizedBox(
        width: double.infinity,
        child: Container(
          height: 140,
          child: Card(
            elevation: 5,
            color: AppColor.white_color,
            clipBehavior: Clip.hardEdge,
            shadowColor: AppColor.black_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FadeInImage(
              fit: BoxFit.cover,
              placeholder:const AssetImage(
                Resources.banker_img,
              ),
              image: const AssetImage(
                Resources.banker_img,
              ),
              imageErrorBuilder: (BuildContext context,
                  Object exception, StackTrace? stackTrace) {
                return Image.asset(
                  Resources.banker_img,
                  width: 80,
                  height: 80,
                );
              },
            ),
          ),
        ),
      ),
    ],
  );

  Widget get marketPlaceTabs => Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: SizedBox(
      height: MediaQuery.of(context).size.height / 1,
      child: FutureBuilder(
        future: loadTabs(),
        builder: (futureContext, snapShot){
          return snapShot.hasData ? CustomTabBar(
            tabLength: appCategories.length,
            tabHeaderList: tabHeaders(),
            tabContentList: loadTabContents(),
          ) :
          const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );

  /*
   * Widget to display different app categories in different tabs
   */

  tabHeaders (){
    List tabHeaderWidgets = <Widget>[];
    for (var category in appCategories) {
      tabHeaderWidgets.add(
          Tab(
            text: category,
          )
      );
    }
    return tabHeaderWidgets;
  }

  loadTabs() async {
    return Future.delayed(const Duration(milliseconds:100), (){
      return true;
    });
  }

  loadTabContents () {
    List tabContentWidgets = <CategoryContentPage>[];
    for (var category in appCategories) {
      tabContentWidgets.add(CategoryContentPage(null, category));
    }
    return tabContentWidgets;
  }
}
