import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/product_integration/controller/product_integration_controller.dart';
import 'package:marketplace/app/common/pages/market_place/dashboard/view/dashboard_page.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_button.dart';
import 'package:marketplace/app/widgets/custom_status_screeen.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'dart:math' as math;

class ProductIntegrationPhoneView extends StatefulWidget {

  const ProductIntegrationPhoneView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductIntegrationPhoneViewState();
  }
}

class ProductIntegrationPhoneViewState extends State{

  bool stopIntegration = false;
  var strAppName = '';

  Widget get processingImage => Center(
    child: Image.asset(Resources.progress_icon_img,
        height: 150,
        width: 150,
        color: AppColor.blue_color
    ),
  );

  Widget get processingText => Center(
    child: CustomText(
      textAlign: TextAlign.center,
      fontWeight: FontWeight.bold,
      textColor: AppColor.black_color,
      fontSize: 20,
      textName: Constants.your_data_processing,
    ),
  );

  Widget get privacyInfo => Padding(
    padding: const EdgeInsets.only(bottom: 30),
    child: Card(
        margin: const EdgeInsets.all(5.0),
        elevation: 10,
        color: AppColor.white_color,
        clipBehavior: Clip.hardEdge,
        shadowColor: AppColor.white_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child:ListTile(
          contentPadding: const EdgeInsets.all(10),
          leading: Image.asset(
            Resources.progress_data_lock_img,
            height: 40,
            width: 30,
          ),
          title: const Text(Constants.your_data_protected, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text(Constants.your_data_protected_msg, style: TextStyle(fontSize:12)),
        )
    ),
  );

  Widget get stopSyncButton => Align(
    alignment: Alignment.bottomCenter,
    child: CustomButton(
        buttonName: const Text(Constants.stop_sync, style: TextStyle(fontWeight: FontWeight.bold)),
        borderColor: AppColor.blue_color,
        fillColor: AppColor.white_color,
        textColor: AppColor.blue_color,
        height: 50 ,
        width: double.infinity,
        onTapAction: (){
          stopIntegration = true;
          popScreen(context);
        }
    ),
  );

  Future integrateApp() async {
    return Future.delayed(const Duration(seconds:4),() async {
      if(stopIntegration == false){
        /*var apps = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
        apps ??= [];
        if(apps is List && apps.isEmpty){
          apps.add({'name':strAppName, "status":"Subscribed"});
          AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
        }
        else{

        }*/
        print("App Name before integration : "+strAppName.toString());

        var apps = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
        var appsNew = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
        apps ??= [];
        // appsNew ??= [];
        if(apps is List && apps.isEmpty){
          apps.add({'name':strAppName.toString(), "status":"Subscribed"});
          AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
        }
        else{
          appsNew = [];
          appsNew = {'name':strAppName.toString(), 'status':"Subscribed"};
          if(apps is List) {
            apps.add(appsNew);
            AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
          } else {
            apps = jsonDecode(apps);
            apps.add(appsNew);
            AppSharedPreference().addString(key:SharedPrefKey.pref_key_integrated_apps, value: jsonEncode(apps));
          }
        }
      }
      return true;
    });
  }

  Widget get integrationProgressView => Column(
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      processingImage,
      processingText,
      const Spacer(),
      privacyInfo,
      stopSyncButton
    ],
  );

  Widget get integrationCompletedView => CustomStatusScreen(
      statusIcon: const Icon(Icons.check_circle_rounded),
      statusText: "You have successfully subscribed Addepar into your App",
      buttonTitle: Constants.back_my_apps,
      buttonCallBack: (){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context){
              return DashboardPage(title: '', selectedTabIndex: 1,);
            }
        ));
      }
  );

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    if(arguments != null) {
      strAppName = arguments['appName'];

      print('Get Argument: APPNAME :: '+strAppName.toString());
    }
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.transparent_color,
        leading: const SizedBox()
      ),
      // key: globalKey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: ControlledWidgetBuilder<ProductIntegrationController>(
            builder: (context, controller) {
              return FutureBuilder(
                future: integrateApp(),
                builder: (context, snapshot){
                  return snapshot.hasData ? integrationCompletedView : integrationProgressView;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}