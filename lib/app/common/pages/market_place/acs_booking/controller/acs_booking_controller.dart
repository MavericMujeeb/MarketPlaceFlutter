import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

import 'package:http/http.dart' as http;

class ACSBookingController extends BaseController {
  List<ProductDao> similarApps = [];
  List<String> keyPoints = [];

  var resp;
  var acsToken;

  int selectedDayIndex = 0;

  bool inProgress = false;


  ACSBookingController(super.repo) {

  }

  Future getAwailableSlots(int dayOfWeek) async {
    inProgress = true;

    acsToken = await await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);
    print("Token from sharedPrefs is : " + acsToken.toString());
    print("Day of week is : " + dayOfWeek.toString());

    resp = await getAwailableSlotsAPI();
    print("Response for available slots is: " + resp.toString());

    inProgress = false;
    // refreshUI();

    return true;
  }

  Future getAwailableSlotsAPI() async {
    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/staffMembers/');
    final response =
    await http.get(url, headers: {"Authorization": "Bearer " + acsToken});

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
}
