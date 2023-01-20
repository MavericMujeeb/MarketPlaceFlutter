import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/view/dashboard_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/controller/my_apps_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/common/utils/javascript_services.dart';
import 'package:marketplace/app/widgets/custom_alert_dialog.dart';
import 'package:marketplace/app/widgets/custom_app_card_new.dart';
import 'package:marketplace/app/widgets/custom_badge.dart';
import 'package:marketplace/app/widgets/custom_gradient_container.dart';
import 'package:marketplace/app/widgets/custom_status_screeen.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/my_apps_dao.dart';

class MyAppsRepository {}

class MyAppsPhonePage extends View {
  @override
  MyAppsPhoneView createState() => MyAppsPhoneView();
}

class MyAppsPhoneView extends ViewState<MyAppsPhonePage, MyAppsController> {
  MyAppsPhoneView() : super(MyAppsController(MyAppsRepository()));

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: AppColor.transparent_color,
        ),
        key: globalKey,
        body: SafeArea(
          child: ControlledWidgetBuilder<MyAppsController>(
            builder: (context, controller) {
              return FutureBuilder(
                future: controller.loadApps(),
                builder: (futureContext, snapShot) {
                  return snapShot.hasData
                      ? controller.installedApps.isNotEmpty
                          ? SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  /*CustomText(
                                  textName: Constants.apps_stats,
                                  textAlign: TextAlign.start,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColor.black_color),
                              const SizedBox(height: 12),
                              appStatsCard(controller),
                              const SizedBox(height: 35),
                              CustomText(
                                  textName: Constants.manage_apps,
                                  textAlign: TextAlign.start,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  textColor: AppColor.black_color),*/
                                  installedAppsList(controller),
                                ],
                              ),
                            )
                          : const SizedBox(
                              child: Center(
                                child: Text(Constants.no_apps_subscried),
                              ),
                            )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              );
            },
          ),
        ),
      );

  Widget appStatsCard(controller) => SizedBox(
        width: double.infinity,
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    textName: controller.getInstalledAppsMessage(),
                    textAlign: TextAlign.start,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: AppColor.black_color),
                const SizedBox(height: 10),
                CustomText(
                    textName: controller.getUnInstalledAppsMessage(),
                    textAlign: TextAlign.start,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    textColor: AppColor.grey_color),
              ],
            ),
          ),
        ),
      );

  Widget myAppsCard(MyAppsController controller, MyAppsDao dao, int index) =>
      Container(
        width: double.infinity,
        height: 110,
        // margin: const EdgeInsets.only(top: 13),
        /*child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: CustomText(
                          textName: dao.app_name,
                          textAlign: TextAlign.start,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          textColor: AppColor.black_color),
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                        textName: Constants.product_name,
                        textAlign: TextAlign.start,
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        textColor: AppColor.grey_color),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomBadge(
                          null,
                          dao.app_status,
                          dao.app_status == 'Subscribed' ? AppColor.tab_integrated : AppColor.tab_in_progress,
                          dao.app_status == 'Subscribed' ? AppColor.white_color : AppColor.txt_gray_black, 24, 80),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: ()=> unsubscribeApp(),
                        child: Image.asset( Resources.settings_img),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),*/
        child: Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GradientContainer(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color1: AppColor.white_color,
              color2: AppColor.white_color,
              borderColor: AppColor.white_color,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  productImageWidget,
                  Expanded(
                    child: Column(
                      children: [productTitleStatusWidget(dao.app_name, dao.app_status), productDescription],
                    ),
                  ),
                  // productTitleWidget,
                ],
              ),
              onPressed: () =>
                  gotoDetailPage(context),
            ),
          ),
        ),
      );

  Widget get productImageWidget => Card(
    elevation: 2,
    shadowColor: Colors.black38,
    child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColor.white_color_70,
          ),
          // margin: EdgeInsets.only(right: 12),
          height: 80.0,
          width: 80.0,
          child: Center(
            child: Image.asset(
              'assets/images/addepar.jpeg',
            ),
          ),
        ),
  );

  Widget get productDescription => Padding(
        padding: const EdgeInsets.only(top: 7.0, left: 12.0),
        child: Text(
          Constants.product_description,
          style: TextStyle(
            fontSize: 11,
            color: AppColor.black_22303e,
          ),
        ),
      );

  Widget productTitleStatusWidget(String productTitle, String strStatus) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Expanded(child: productTitleWidget(productTitle)), appStatus(strStatus)],
            ),
          )
        ],
      );

  Widget appStatus(String strStatus) => Container(
    decoration: BoxDecoration(
      // border: Border.all(color: AppColor.blue_0077cc, width: 1),
      borderRadius: BorderRadius.circular(4),
      color: AppColor.green_color,
    ),
    padding: EdgeInsets.all(5),
    child: Text(
      strStatus.toUpperCase(),
      style: TextStyle(
        color: AppColor.white_color,
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget productTitleWidget(String productTitle) => Text(
    productTitle,
    // "01234 0123456789 0123456789 01234 01234 1234",
    style: const TextStyle(
      color: Color(0xFF22303E),
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      fontSize: 15,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );

  gotoDetailPage(context) async {
    /*if (detailActionCallBack != null) {
      Future.delayed(const Duration(microseconds: 500), () {
        navigateToProductDetailScreen(context);
        detailActionCallBack!();
      });
    } else {*/
    Future.delayed(const Duration(microseconds: 500), () {
      navigateToProductDetailScreen(context);
    });
    // }
  }

  Widget installedAppsList(MyAppsController controller) => ListView.builder(
        itemCount: controller.installedApps.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          MyAppsDao dao = controller.installedApps[index];
          return myAppsCard(controller, dao, index);
        },
      );

  loadData(MyAppsController controller) {
    return controller.loadApps();
  }

  Future<void> unsubscribeApp() async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return CustomAlertDialogWidget(
            title: Constants.customAlertDialogTitle,
            description: "Do you want to unsubscribe Addepar app?",
            cancelButtonName: Constants.customAlertDialogCancelButtonName,
            confirmButtonName: Constants.customAlertDialogConfirmButtonName,
            cancelActionCallBack: () {
              popScreen(context);
            },
            confirmActionCallBack: () {
              //pop dialog and proceed
              popScreen(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CustomStatusScreen(
                      statusIcon: const Icon(Icons.check_circle_rounded),
                      statusText: "You have successfully unsubscribed Addepar",
                      buttonTitle: Constants.back_my_apps,
                      buttonCallBack: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return DashboardPage(
                            title: '',
                            selectedTabIndex: 1,
                          );
                        }));
                      })));
              AppSharedPreference()
                  .deleteString(key: SharedPrefKey.pref_key_integrated_apps);
            },
          );
        });
  }
}
