import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/app/common/pages/base/controller/base_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

import 'package:oauth2/oauth2.dart' as oauth2;

import 'package:http/http.dart' as http;

class ACSBookingController extends BaseController {
  List<ProductDao> similarApps = [];
  List<String> keyPoints = [];

  var resp;
  var respGetBanker;
  var respBooking;
  var acsToken;
  var serviceId = '';

  int selectedDayIndex = 0;
  var selectedBankerEmailId = '';
  var selectedBankerId = '';

  bool inProgress = false;
  bool inProgressFullScreen = false;

  var pickedStartTime = '';
  var pickedEndTime = '';

  var defaultDate = '';
  var strCode = '';

  ACSBookingController(super.repo) {}

  Future getBankersList() async {
    inProgress = true;

    acsToken = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);

    respGetBanker = await getBankersListAPI();

    inProgress = false;

    // DateTime today = new DateTime.now();
    // String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    // getAwailableSlots(today.weekday - 1, formattedDate);

    return true;
  }

  Future getAwailableSlots(int dayOfWeek, String date) async {
    inProgress = true;

    acsToken = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);
    serviceId = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_service_id);

    resp = await getAwailableSlotsAPI(date);

    inProgress = false;
    // refreshUI();

    // return true;
  }

  Future getBankersListAPI() async {
    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/staffMembers/');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer " + acsToken});

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
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

  Future getBookingDelegateToken() async {
    inProgressFullScreen = true;

    respBooking = await getBookingDelegateTokenAPI();
    print("Response for get token is : "+respBooking.toString());

    inProgressFullScreen = false;

    bookAppointAPI();

    return true;
  }

  Future getBookingDelegateTokenAPI() async {
    var url = Uri.parse(
        'https://login.microsoftonline.com/4c4985fe-ce8e-4c2f-97e6-b037850b777d/oauth2/v2.0/token');

    final response = await http.post(
      url,
      headers: {
        // "Authorization": "Basic ZTYxOTcyNjMtYjk4Ni00ZjA4LTlhMjctMDhhNGVjMWI1YzhlOjRrNDhRfndiaXZseGRGSWJ5VmNOZzN5a3VubE5kSS52Y3lDMktiaTA=",
        "Content-Type": "application/x-www-form-urlencoded",
        "Host": "login.microsoftonline.com",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Content-Length": "928",
      },
      body: {
        "grant_type": "authorization_code",
        // "code": "0.AXwA_oVJTI7OL0yX5rA3hQt3fWNyGeaGuQhPmicIpOwbXI67AAA.AgABAAIAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P9j2q4sbzEII8qjD5V6ipdgvC8fcAUKw6Sykk_F15FM29jG-fUjtvrdUz_i81f-ZnvHgnGaPGDcuofNeWKxe0vp1MRJGRnIfBM5aiE-TUtZEYvE3h7pkMZGNEcYTI2yHCW8DWRHKYRMcYRZuQxMreHRwy8NrZz_xhmJd_ICM8mLtuEaAujXE5LpnsXI6f_moVbwQ107Tuj0usDRZDbin6hUytIM0U4nPWAuzKOOvjyMx34ayAenckByLrHFKM94lftdSecR24HLx05GxzRAOlY1QyRPWxqqDrm3bzwL0_ZCnjMmwwsZ6bWyxbKdSswODYnjMDwMY3dK7tB1ssWKGJbl_SuxcvFLIs76kH2ZAIQiggS0Bp5CCslzXtPrVh_pxWPvRxmKeiROtj8PmVSvDjC5Z-pRzRAJWG8Q4Q9KD48CBXdWtcglAI_Tn5w1UK5kfiUeDe1Ny6n1o4ruhKUNqRRfkAnN9fTXJB1bJy6OoxnCbVhMZjrmPJvDvqNvrgS83TTc5g-1ebSnBb69k-gptB9YlekoD4Spu7ILXWYEyywf8Nbs-J_MwplgY6Ok3VMPgS_9VYcah-VzRdSEv8Zu1jHY5sir-Fywu94BwI-zMG8nDDfRIO8-_N8n7hWsLWPNVSQSqqCc-3C0Q0GqfhXSHCOHOkEDdtNjd1fF2AZTzkdqhtBUOw&state=12345&session_state=de8cd894-ea1a-4010-8961-9fe6c632b746",
        "code": strCode,
        "redirect_uri": "https%3A%2F%2Foauth.pstmn.io%2Fv1%2Fbrowser-callback",
        "client_id": "e6197263-b986-4f08-9a27-08a4ec1b5c8e",
        "scope": "https://graph.microsoft.com/.default",
      },
    );

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
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

    var url = Uri.parse('https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/$serviceId/staffMembers/');

    final response =
    await http.post(url, headers: {"Authorization": "Bearer " + acsToken, "Content-Type": "application/json"}, body: requestString);
    // print("Response code is : "+response.statusCode.toString());

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }
}
