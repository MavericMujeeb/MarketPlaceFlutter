import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

import 'package:http/http.dart' as http;

class ACSBookingController extends BaseController {
  List<ProductDao> similarApps = [];
  List<String> keyPoints = [];

  var resp;
  var respGetBanker;
  var respBooking;
  var acsToken;

  int selectedDayIndex = 0;
  var selectedBankerEmailId = '';
  var selectedBankerId = '';

  bool inProgress = false;
  bool inProgressFullScreen = false;

  var pickedStartTime = '';
  var pickedEndTime = '';

  var defaultDate = '';

  ACSBookingController(super.repo) {}

  Future getBankersList() async {
    inProgress = true;

    acsToken = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);

    respGetBanker = await getBankersListAPI();
    print("Response for available bankers list API is : " +
        respGetBanker.toString());

    inProgress = false;

    // DateTime today = new DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    // getAwailableSlots(today.weekday - 1, formattedDate);

    return true;
  }

  Future getBankersListAPI() async {
    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/staffMembers/');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer " + acsToken});

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  Future getAwailableSlots(int dayOfWeek, String date) async {
    inProgress = true;

    acsToken = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);

    resp = await getAwailableSlotsAPI(date);
    print("Response for available slots is: " + resp.toString());

    inProgress = false;
    // refreshUI();

    // return true;
  }

  Future getAwailableSlotsAPI(String date) async {
    acsToken = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);

    final body = {
      "schedules": ["$selectedBankerEmailId"],
      "startTime": {
        "dateTime": date + "T08:00:00",
        "timeZone": "Pacific Standard Time"
      },
      "endTime": {
        "dateTime": date + "T17:00:00",
        "timeZone": "Pacific Standard Time"
      },
      "availabilityViewInterval": 30
    };

    final requestString = json.encode(body);

    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/users/admin@27r4l5.onmicrosoft.com/calendar/getSchedule');
    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer " + acsToken,
          "Content-Type": "application/json"
        },
        body: requestString);

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  List<String> getTimeSlotsToDisplay(String startTime, String endTime) {
    List<String> startWorkinghoursSplitList = startTime.split(":");
    List<String> endWorkinghoursSplitList = endTime.split(":");
    var startTimeFromList = startWorkinghoursSplitList.isNotEmpty
        ? startWorkinghoursSplitList.elementAt(0)
        : "8";
    var endTimeFromList = endWorkinghoursSplitList.isNotEmpty
        ? endWorkinghoursSplitList.elementAt(0)
        : "17";
    List<String> availableTimeSlotsList = [];
    for (var i = int.parse(startTimeFromList);
        i < int.parse(endTimeFromList);
        i++) {
      availableTimeSlotsList.add("$i:00 - $i:30");
      availableTimeSlotsList.add("$i:30 - ${i + 1}:00");
    }
    return availableTimeSlotsList;
  }


  Future actionBookAppointment() async{
    inProgressFullScreen = true;

    respBooking = await bookAppointAPI();

    inProgressFullScreen = false;

    return true;
  }

  Future bookAppointAPI() async {
    final body = {
      "@odata.type": "#microsoft.graph.bookingAppointment",
      "customerTimeZone": "America/Chicago",
      "smsNotificationsEnabled": false,
      "endDateTime": {
        "@odata.type": "#microsoft.graph.dateTimeTimeZone",
        // "dateTime": "2023-01-25T14:30:00.0000000+00:00",
        "dateTime": defaultDate+"T"+pickedEndTime+":00.0000000+00:00",
        "timeZone": "UTC"
      },
      "isLocationOnline": true,
      "optOutOfCustomerEmail": false,
      "anonymousJoinWebUrl": null,
      "staffMemberIds":["$selectedBankerId"],
      "postBuffer": "PT10M",
      "preBuffer": "PT5M",
      "price": 10.0,
      "priceType@odata.type": "#microsoft.graph.bookingPriceType",
      "priceType": "fixedPrice",
      "reminders@odata.type": "#Collection(microsoft.graph.bookingReminder)",
      "reminders": [
        {
          "@odata.type": "#microsoft.graph.bookingReminder",
          "message": "This service is tomorrow",
          "offset": "P1D",
          "recipients@odata.type": "#microsoft.graph.bookingReminderRecipients",
          "recipients": "allAttendees"
        },
        {
          "@odata.type": "#microsoft.graph.bookingReminder",
          "message": "Please be available to enjoy your lunch service.",
          "offset": "PT1H",
          "recipients@odata.type": "#microsoft.graph.bookingReminderRecipients",
          "recipients": "customer"
        },
        {
          "@odata.type": "#microsoft.graph.bookingReminder",
          "message": "Please check traffic for next cater.",
          "offset": "PT2H",
          "recipients@odata.type": "#microsoft.graph.bookingReminderRecipients",
          "recipients": "staff"
        }
      ],
      "serviceId": "555c5745-57a6-4bb4-8c5f-1c5f99a21b60",
      "serviceLocation": {
        "@odata.type": "#microsoft.graph.location",
        "address": {
          "@odata.type": "#microsoft.graph.physicalAddress",
          "city": "Irving",
          "countryOrRegion": "USA",
          "postalCode": "75035",
          "postOfficeBox": null,
          "state": "TX",
          "street": "6400 Las Colinas Blvd",
          "type@odata.type": "#microsoft.graph.physicalAddressType",
          "type": null
        },
        "coordinates": null,
        "displayName": "Citi office",
        "locationEmailAddress": null,
        "locationType@odata.type": "#microsoft.graph.locationType",
        "locationType": null,
        "locationUri": null,
        "uniqueId": null,
        "uniqueIdType@odata.type": "#microsoft.graph.locationUniqueIdType",
        "uniqueIdType": null
      },
      "serviceName": "Document Sharing",
      "serviceNotes": "Customer requires punctual service.",
      "startDateTime": {
        "@odata.type": "#microsoft.graph.dateTimeTimeZone",
        // "dateTime": "2023-01-25T14:00:00.0000000+00:00",
        "dateTime": defaultDate+"T"+pickedStartTime+":00.0000000+00:00",
        "timeZone": "UTC"
      },
      "maximumAttendeesCount": 5,
      "filledAttendeesCount": 1,
      "customers@odata.type": "#Collection(microsoft.graph.bookingCustomerInformation)",
      "customers": [
        {
          "@odata.type": "#microsoft.graph.bookingCustomerInformation",
          "customerId": "AAMkADgxMDg4NWMzLTIzNWMtNDViYy1hYWJhLTE0NTZjZDgzODRhYQBGAAAAAACttVURj_1bRqcklkXFuHxLBwD8ukkXMomQSraJ697DBpjEAAAAAAEOAAD8ukkXMomQSraJ697DBpjEAAACELssAAA=",
          "name": "Melinda Gates",
          "emailAddress": "acharya.83@gmail.com",
          "phone": "862-228-7032",
          "notes": null,
          "location": {
            "@odata.type": "#microsoft.graph.location",
            "displayName": "Customer",
            "locationEmailAddress": null,
            "locationUri": "",
            "locationType": null,
            "uniqueId": null,
            "uniqueIdType": null,
            "address": {
              "@odata.type": "#microsoft.graph.physicalAddress",
              "street": "",
              "city": "",
              "state": "",
              "countryOrRegion": "",
              "postalCode": ""
            },
            "coordinates": {
              "altitude": null,
              "latitude": null,
              "longitude": null,
              "accuracy": null,
              "altitudeAccuracy": null
            }
          },
          "timeZone":"America/Chicago",
          "customQuestionAnswers": [
            {
              "questionId": "3bc6fde0-4ad3-445d-ab17-0fc15dba0774",
              "question": "API create appointment?",
              "answerInputType": "text",
              "answerOptions": [],
              "isRequired": true,
              "answer": "25",
              "selectedOptions": []
            }
          ]
        }
      ]
    };

    final requestString = json.encode(body);

    acsToken = await AppSharedPreference().getString(key: SharedPrefKey.prefs_acs_token);

    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/appointments');
    final response =
    await http.post(url, headers: {"Authorization": "Bearer " + acsToken, "Content-Type": "application/json"}, body: requestString);
    // print("Response code is : "+response.statusCode.toString());

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
}
