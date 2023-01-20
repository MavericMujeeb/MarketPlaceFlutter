import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_js/flutter_js.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/common/utils/javascript_services.dart';
import 'package:marketplace/app/widgets/custom_badge.dart';
import 'package:marketplace/app/widgets/custom_gradient_container.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';

import 'custom_alert_dialog.dart';

class CustomAppCardNew extends StatelessWidget {
  final String productImagePath;
  final String productTitle;
  final String productPopularity;
  final String productStatus;
  final Color statusColor;
  final Color statusTextColor;
  Function? detailActionCallBack;
  final BuildContext context;

  CustomAppCardNew(Key? key,
      {required this.productImagePath,
      required this.productTitle,
      required this.productPopularity,
      required this.productStatus,
      required this.statusColor,
      required this.statusTextColor,
      this.detailActionCallBack, required this.context})
      : super(key: key);

  final box = GetStorage();

  Widget get productImageWidget => Card(
    elevation: 2,
    shadowColor: Colors.black38,
    child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColor.white_color_70,
          ),
          height: 90.0,
          width: 80.0,
          child: Center(
            child: Image.asset(
              productImagePath,
            ),
          ),
        ),
  );

  Widget get statusTextWidget => Text(
        productPopularity,
        maxLines: 2,
        style: const TextStyle(
            color: Color(0xFF22303E),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w300,
            fontSize: 12,
            overflow: TextOverflow.ellipsis),
      );

  Widget get appStatus => GestureDetector(
    onTap: () {
      print('Clicked on Subscribe on : '+productTitle.toString());
      integrateAction(context);
    },
    child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.blue_0077cc, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.all(5),
          child: Text(
            Constants.app_status_subscribe.toUpperCase(),
            style: TextStyle(
              color: AppColor.blue_0077cc,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
  );

  Widget get statusBadge =>
      CustomBadge(null, productStatus, statusColor, statusTextColor, 20, 75);

  Widget get productTitleWidget => Text(
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

  Widget get productDescription => Padding(
        padding: const EdgeInsets.only(top: 7.0),
        child: Text(
          Constants.product_description,
          style: TextStyle(
            fontSize: 11,
            color: AppColor.black_22303e,
          ),
        ),
      );

  Widget get productTitleStatusWidget => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: productTitleWidget), appStatus],
          )
        ],
      );

  gotoDetailPage(context) async {
    /*final JavascriptRuntime jsRuntime = getJavascriptRuntime();
    // final number = ValueNotifier(0);

    try {
      final result = await addFromJs(jsRuntime, Resources.number, 1);
      Resources.number = result;
    } on PlatformException catch (e) {
      print('error: ${e.details}');
    }*/

    if (detailActionCallBack != null) {
      Future.delayed(const Duration(microseconds: 500), () {
        navigateToProductDetailScreen(context);
        detailActionCallBack!();
      });
    } else {
      Future.delayed(const Duration(microseconds: 500), () {
        navigateToProductDetailScreen(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 110,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      children: [productTitleStatusWidget, productDescription],
                    ),
                  ),
                ),
                // productTitleWidget,
              ],
            ),
            onPressed: () =>
                productTitle == 'Addepar' ? gotoDetailPage(context) : null,
          ),
        ),
      ),
    );
  }

  Future<void> integrateAction(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return CustomAlertDialogWidget(
            title: Constants.customAlertDialogTitle,
            description: Constants.customAlertDialogDescription,
            cancelButtonName: Constants.customAlertDialogCancelButtonName,
            confirmButtonName: Constants.customAlertDialogConfirmButtonName,
            cancelActionCallBack: () {
              popScreen(context);
            },
            confirmActionCallBack: () {
              //pop dialog and proceed
              popScreen(context);
              navigateToProductIntegrationProcessScreen(context, productTitle.toString());
              // integrateApp();
            },
          );
        });
  }

  Future integrateApp() async {
    return Future.delayed(const Duration(seconds:2),() async {
      var apps = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
      var appsNew = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
      apps ??= [];
      // appsNew ??= [];
      if(apps is List && apps.isEmpty){
        apps.add({'name':productTitle.toString(), "status":"Subscribed"});
        AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
      }
      else{
        appsNew = [];
        appsNew = {'name':productTitle.toString(), 'status':"Subscribed"};
        if(apps is List) {
          apps.add(appsNew);
          AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
        } else {
          apps = jsonDecode(apps);
          apps.add(appsNew);
          AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
        }
      }
      return true;
    });
  }
}

/*Future<int> addFromJs(JavascriptRuntime jsRuntime, int firstNumber, int secondNumber) async {
  String blockJs = await rootBundle.loadString("assets/addition.js");
  final jsResult = jsRuntime.evaluate("""${blockJs}add($firstNumber,$secondNumber)""");
  final jsStringResult = jsResult.stringResult;
  AppSharedPreference().addString(key:SharedPrefKey.page_count.toString(), value: jsResult.stringResult);
  print("Details screen open count: "+jsStringResult);
  return int.parse(jsStringResult);
}*/
