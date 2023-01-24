import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/home/view/home_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/my_apps_page.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';
// import 'package:marketplace/data/repositories/acs_chat_calling_repository.dart';

import '../../../../../utils/constants.dart';
import '../../controller/acs_booking_controller.dart';

import 'package:http/http.dart' as http;

class ACSBookingPhonePage extends View {
  const ACSBookingPhonePage({Key? key}) : super(key: key);

  @override
  ACSBookingPhonePageState createState() => ACSBookingPhonePageState();
}

class ACSBookingPhonePageState
    // extends ViewState<ACSBookingPhonePage, ACSBookingController> {
    extends State<ACSBookingPhonePage> {
  // ACSBookingPhonePageState(): super(ACSBookingController(ACSChatCallingDataRepository()));
  // ACSBookingPhonePageState();

  ACSBookingController? acsBookingController = ACSBookingController(ACSChatCallingDataRepository());

  static const Channel = MethodChannel('com.citi.marketplace.host');

  DateTime setDate = DateTime.now();

  int selectedTabIndex = 0;

  static const MARGIN_TOP = 10.0;
  static const MARGIN_BOTTOM = 10.0;
  static const MARGIN_LEFT = 20.0;
  static const MARGIN_RIGHT = 20.0;
  static const FONT_SIZE = 24.0;
  static const BUTTON_BORDER_RADIUS = 16.0;
  static const spacing_4 = 4.0;
  static const spacing_6 = 6.0;
  static const spacing_8 = 8.0;
  static const spacing_10 = 10.0;
  static const spacing_12 = 12.0;
  static const spacing_14 = 14.0;
  static const spacing_16 = 16.0;
  static const spacing_18 = 18.0;

  final List<bool> _selected = List.generate(10, (i) => false);

  // var resp;
  var respBooking;
  var ascToken = '';
  DateTime today = new DateTime.now();

  int selectedDayIndex = 0;

  // bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // DateTime today = new DateTime.now();
    // DateTime date = new DateTime(today.year, today.month, today.day);

    // getAwailableSlots(today.weekday - 1);

    print("Check fro controller : "+acsBookingController.toString());

    // acsBookingController?.getAwailableSlots(today.weekday - 1);
    /*setState(() {

    });*/

    getAppoinments(today.weekday - 1);
  }

  getAppoinments(int weekday) async{
    await acsBookingController?.getAwailableSlots(weekday);
    setState(() {

    });
  }

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
              onPressed: () => popScreen(context),
              icon: const Icon(Icons.chevron_left)),
          title: appBarTitle,
        ),
        // key: globalKey,
        body: SafeArea(
          child: bookingContent,
          /*child: ControlledWidgetBuilder<ACSBookingController>(
            builder: (context, controller) {
              // acsBookingController = controller;
              print("Check for controller in view : "+acsBookingController.toString());
              return bookingContent;
            },
          ),*/
        ),
      );

  Widget get bookingContent => Stack(
        children: [
          Positioned(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(spacing_12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    containerPickDate(),
                    vSpacer(spacing_10),
                    containerPickTimeSlot(),
                    vSpacer(spacing_12),
                    bottomBookingButton(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Visibility(
              visible: acsBookingController!.inProgress ? true : false,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black12,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      );

  void showToast(String s, String day, String dayofWeek) {
    final snackBar = SnackBar(
      content: Text(s.toString() + " " + day.toString() + " " + dayofWeek),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // getAwailableSlots();
  }

  Widget bottomBookingButton() => GestureDetector(
        onTap: () {
          actionBookAppointment();
        },
        child: customButton(
            const Icon(null, size: 0),
            Constants.bookAnAppointment,
            AppColor.brown_231d18,
            AppColor.brown_231d18,
            Colors.white),
      );

  Widget containerPickDate() => Card(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contentTitle(Constants.pickDate),
              vSpacer(10),
              CalendarDatePicker(
                  initialDate: setDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 100000)),
                  onDateChanged: (DateTime value) {
                    /*String formattedDate =
                        DateFormat('dd-MM-yyyy').format(value);
                    String formattedDay = DateFormat('EEEE').format(value);*/
                    /*showToast(
                        formattedDate, formattedDay, value.weekday.toString());*/
                    selectedDayIndex = value.weekday - 1;

                    // acsBookingController?.getAwailableSlots(selectedDayIndex);
                    getAppoinments(selectedDayIndex);

                    print("SelectedDayIndex : "+selectedDayIndex.toString());
                    print("Length is : "+ acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]['timeSlots'].length.toString());

                  }),
            ],
          ),
        ),
      );

  Widget containerPickTimeSlot() => Card(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contentTitle(Constants.pickTimeSlot),
              vSpacer(10),
              acsBookingController!.inProgress ? SizedBox(
                height: 100,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ) : acsBookingController!.resp != null && acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]['timeSlots']
                  .length > 0
                  ? listSlots()
                  : SizedBox(
                height: 100,
                child: Center(
                  child: CustomText(
                      textName: Constants.noAppointments,
                      textAlign: TextAlign.center,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              /*FutureBuilder(
                future: acsBookingController!.getAwailableSlots(today.weekday - 1),
                builder: (buildContext, snapShot) {
                  return snapShot.hasData
                      ? acsBookingController!.resp != null && acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]['timeSlots']
                      .length > 0
                          ? listSlots()
                          : SizedBox(
                              height: 100,
                              child: Center(
                                child: CustomText(
                                    textName: Constants.noAppointments,
                                    textAlign: TextAlign.center,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                      : SizedBox(
                          height: 100,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                },
              ),*/
              // listSlots(),
            ],
          ),
        ),
      );

  Widget contentTitle(String strLabel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: CustomText(
          textName: strLabel,
          textAlign: TextAlign.start,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );

  Widget listSlots() => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: 10,
      itemCount: acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]['timeSlots']
          .length,
      itemBuilder: (BuildContext context, int index) {
        return slotCellItem(index);
      });

  Widget slotCellItem(int index) => GestureDetector(
        onTap: () => {
          print('Clicked on index: $index'),
          for (int i = 0; i < 10; i++) {setState(() => _selected[i] = false)},
          setState(() => _selected[index] = true)
        },
        child: Card(
          color: _selected[index] ? AppColor.brown_231d18 : Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.only(top: spacing_10),
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: spacing_6, vertical: spacing_6),
            child: CustomText(
              // textName: '01:45 PM - 02:45 PM',
              textName: displayTimeSlot(index),
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              textColor: _selected[index] ? Colors.white : Colors.black,
            ),
          ),
        ),
      );

  Widget get appBarTitle => Column(
        children: [
          CustomText(
            textName: Constants.bookAnAppointment,
            textAlign: TextAlign.center,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            textColor: Colors.black,
          ),
          vSpacer(10),
          CustomText(
            textName: Constants.contactCenterToolbarMsgPrivateBanker,
            textAlign: TextAlign.center,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            textColor: AppColor.black_color_54,
          ),
        ],
      );

  Widget vSpacer(double height) => SizedBox(
        height: height,
      );

  Widget hSpacer(double width) => SizedBox(
        width: width,
      );

  Widget customButton(Icon icon, String strLabel, Color bgColorButton,
          Color borderColorButton, Color iconTextColor) =>
      Container(
        height: 48,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: spacing_14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColorButton, width: 1),
          color: bgColorButton,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: spacing_10),
              child: Center(
                child: icon,
              ),
            ),
            CustomText(
                textName: strLabel,
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                textColor: iconTextColor),
          ],
        ),
      );

 /* Future getAwailableSlots(int dayOfWeek) async {
    // inProgress = true;
    ascToken = await await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_acs_token);
    print("Token from sharedPrefs is : " + ascToken.toString());
    print("Day of week is : " + dayOfWeek.toString());

    resp = await getAwailableSlotsAPI();
    print("Response for available slots is: " + resp.toString());

    inProgress = false;

    *//*print("Default day start timeslot is : " +
        resp['value'][0]['workingHours'][dayOfWeek]['timeSlots'][0]['startTime']
            .toString());
    print("Default day end timeslot is : " +
        resp['value'][0]['workingHours'][dayOfWeek]['timeSlots'][0]['endTime']
            .toString());*//*

    return true;
  }

  Future getAwailableSlotsAPI() async {
    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/staffMembers/');
    final response =
        await http.get(url, headers: {"Authorization": "Bearer " + ascToken});

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }*/

  displayTimeSlot(int index) {
    var respStartTime = acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]
            ['timeSlots'][index]['startTime']
        .toString();
    var respEndTime = acsBookingController!.resp['value'][0]['workingHours'][selectedDayIndex]
            ['timeSlots'][index]['endTime']
        .toString();

    DateFormat formatter_display_time = DateFormat('hh:mm a');

    DateTime tempStartTimeFormat =
        new DateFormat("hh:mm:ss.sssZ").parse(respStartTime, true);
    DateTime tempEndTimeFormat =
        new DateFormat("hh:mm:ss.sssZ").parse(respEndTime, true);

    var strStartTime = formatter_display_time.format(tempStartTimeFormat);
    var strEndTime = formatter_display_time.format(tempEndTimeFormat);

    return strStartTime + " - " + strEndTime;
  }

  Future actionBookAppointment() async{

    respBooking = await bookAppointAPI();
    print("Response for Book an Appointment is: " + respBooking.toString());

    // inProgress = false;

    return true;
  }

  Future bookAppointAPI() async {
    final body = {
      "@odata.type": "#microsoft.graph.bookingAppointment",
      "customerTimeZone": "America/Chicago",
      "smsNotificationsEnabled": false,
      "endDateTime": {
        "@odata.type": "#microsoft.graph.dateTimeTimeZone",
        "dateTime": "2023-01-21T20:30:00.0000000+00:00",
        "timeZone": "UTC"
      },
      "isLocationOnline": true,
      "optOutOfCustomerEmail": false,
      "anonymousJoinWebUrl": null,
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
        "dateTime": "2023-01-21T20:00:00.0000000+00:00",
        "timeZone": "UTC"
      },
      "maximumAttendeesCount": 5,
      "filledAttendeesCount": 1,
      "customers@odata.type": "#Collection(microsoft.graph.bookingCustomerInformation)",
      "customers": [
        {
          "@odata.type": "#microsoft.graph.bookingCustomerInformation",
          "customerId": "7ed53fa5-9ef2-4f2f-975b-27447440bc09",
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

    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/solutions/bookingBusinesses/GatesFamilyOffice@27r4l5.onmicrosoft.com/appointments');
    final response =
    await http.post(url, headers: {"Authorization": "Bearer " + ascToken, "Content-Type": "application/json"}, body: requestString);
    // print("Response code is : "+response.statusCode.toString());

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return view;
  }
}
