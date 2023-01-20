import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/my_apps_dao.dart';

class MyAppsController extends BaseController {

  List<MyAppsDao> installedApps = [];
  List<MyAppsDao> unInstalledApps = [];

  MyAppsController(super.repo){
    GetStorage();
  }

  Future<bool> loadApps () async {
    return Future.delayed(const Duration(milliseconds: 1000), ()async {
      installedApps = [];
      var apps = await AppSharedPreference().getString(key: SharedPrefKey.pref_key_integrated_apps);
      if(apps is List){
        for(var app in apps) {
          installedApps.add(MyAppsDao(app['name'], app['status']));
        }
      }
      else if(apps !=null && apps.runtimeType == String){
        apps = jsonDecode(apps);
        if(apps is List){
          for(var app in apps) {
              installedApps.add(MyAppsDao(app['name'], app['status']));
          }
        }
      }
      return true;
    });
  }

  getInstalledAppsCount(){
    return installedApps.length;
  }

  getUnInstalledAppsCount(){
    return unInstalledApps.length;
  }

  getInstalledAppsMessage () {
    int count = getInstalledAppsCount();
    String message;
    switch(count){
      case 1:
        message = " App subscribed";
        break;
      default:
        message =" apps subscribed";
        break;
    }
    return getInstalledAppsCount().toString() + message;
  }

  getUnInstalledAppsMessage () {
    return "0 unsubscribed";
  }
}