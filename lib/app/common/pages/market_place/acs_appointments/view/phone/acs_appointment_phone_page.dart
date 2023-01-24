import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';

import '../../../../../utils/constants.dart';
import '../../controller/acs_appointment_controller.dart';

import 'package:http/http.dart' as http;

class ACSAppointmentPhonePage extends View {
  const ACSAppointmentPhonePage({Key? key}) : super(key: key);

  @override
  ACSAppointmentPhonePageState createState() => ACSAppointmentPhonePageState();
}

class ACSAppointmentPhonePageState
    extends ViewState<ACSAppointmentPhonePage, ACSAppointmentController> {
  ACSAppointmentPhonePageState()
      : super(ACSAppointmentController(ACSChatCallingDataRepository()));

  ACSAppointmentController? productDetailsController;

  static const Channel = MethodChannel('com.citi.marketplace.host');

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

  var resp;

  var acsToken = '';
  var serviceId = '';

  Future<void> joinCallClick(meetingLink) async {
    final bool status = await Channel.invokeMethod(
        'joinCallClick', <String, String>{'meeting_id': meetingLink});
  }

  /*Future<void> startCallClick() async {
    final int batteryLevel =
        await Channel.invokeMethod('startCallClick', <String, String>{
      'message':
          'This is a Toast from From Flutter to Android Native Code Yes, It is working'
    });
    print(batteryLevel);
  }

  Future<void> joinCallClick() async {
    final int batteryLevel =
        await Channel.invokeMethod('joinCallClick', <String, String>{
      'message':
          'This is a Toast from From Flutter to Android Native Code Yes, It is working'
    });
    print(batteryLevel);
  }

  Future<void> chatClick() async {
    final int batteryLevel =
        await Channel.invokeMethod('chatClick', <String, String>{
      'message':
          'This is a Toast from From Flutter to Android Native Code Yes, It is working'
    });
    print(batteryLevel);
  }*/

  @override
  Widget get view => Scaffold(
        backgroundColor: AppColor.bg_color_contact,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: AppColor.transparent_color,
        ),
        key: globalKey,
        body: SafeArea(
          child: ControlledWidgetBuilder<ACSAppointmentController>(
            builder: (context, controller) {
              productDetailsController = controller;
              return Column(
                children: [
                  horizontalDivider,
                  FutureBuilder(
                    // future: getAppointments(),
                    future: getToken(),
                    builder: (buildContext, snapShot) {
                      return snapShot.hasData
                          ? resp != null && resp['value']!=null && resp['value'].length > 0
                              ? appointmentContent
                              : Expanded(
                                  child: Center(
                                    child: CustomText(
                                        textName: Constants.noAppointments,
                                        textAlign: TextAlign.center,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                          : Expanded(
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    },
                  ),
                  // appointmentContent,
                ],
              );
            },
          ),
        ),
      );

  Widget get appointmentContent => Expanded(
        child: Stack(
          children: [
            Positioned(top: 14, left:14, right: 14, bottom:80, child: listAppointments),
            Positioned(
                left:14.0, right: 14.0, bottom:0,
                child: GestureDetector(
              onTap: () {
                Future.delayed(const Duration(microseconds: 500), () {
                  navigateToBookingScreen(context);
                });
              },
              child: customButton(48, Constants.bookAnAppointment,
                  AppColor.brown_231d18, AppColor.brown_231d18, Colors.white),
            )),
          ],
        ),
      );

  Widget get horizontalDivider => Container(
        height: 0.5,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: spacing_18),
        color: AppColor.black_color_54,
      );

  Widget get listAppointments => ListView.builder(
      itemCount: resp['value'].length,
      itemBuilder: (BuildContext context, int index) {
        return appointmentCellItem(index);
      });

  Widget appointmentCellItem(int index) => Container(
        // height: 174,
        width: double.infinity,
        child: Card(
          color: Colors.white,
          // elevation: 2.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: spacing_14, vertical: spacing_18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    textName: 'Hello Kishan!',
                    textAlign: TextAlign.start,
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
                vSpacer(10.0),
                CustomText(
                    textName: 'You have appointment scheduled on ' +
                        getFormattedMessage(index),
                    textAlign: TextAlign.start,
                    fontSize: 15,
                    fontWeight: FontWeight.w300),
                vSpacer(10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.document_scanner,
                          size: 14,
                          color: AppColor.brown_231d18,
                        ),
                        hSpacer(spacing_4),
                        CustomText(
                            textName: Constants.viewDetails,
                            textAlign: TextAlign.start,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          joinCallClick(
                              resp['value'][index]['onlineMeeting']['joinUrl']);
                        },
                        child: customButton(
                            40,
                            Constants.joinMeeting,
                            Colors.white,
                            AppColor.brown_231d18,
                            AppColor.brown_231d18)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget vSpacer(double height) => SizedBox(
        height: height,
      );

  Widget hSpacer(double width) => SizedBox(
        width: width,
      );

  Future getToken() async {
    serviceId = await AppSharedPreference()
        .getString(key: SharedPrefKey.prefs_service_id);
    var url = Uri.parse(
        'https://login.microsoftonline.com/4c4985fe-ce8e-4c2f-97e6-b037850b777d/oauth2/v2.0/token');
    final response = await http.post(url, body: {
      'client_id': '10114ce6-840d-419b-917e-49b90f3c1f2a',
      'scope': 'https://graph.microsoft.com/.default',
      'client_secret': 'IT98Q~LAiYb4COAtX7zwJDFYa2.g~iDTvMuoZaS-',
      'grant_type': 'client_credentials'
    });

    var respToken = jsonDecode(response.body);

    print("Response token is : " + respToken['access_token']);
    acsToken = respToken['access_token'];

    print("Token is : " + acsToken);
    // acsToken = AppSharedPreference().getString(key: SharedPrefKey.prefs_acs_token);
    AppSharedPreference()
        .addString(key: SharedPrefKey.prefs_acs_token, value: acsToken);

    // acsToken = await AppSharedPreference().getString(key: SharedPrefKey.prefs_acs_token);

    resp = await getAppointmentsAPI();

    print("Response for get appointment is : " + resp.toString());
    return true;
  }

  Future getAppointmentsAPI() async {
    var nowDate = DateTime.now();
    var thirtydaysDate = DateTime(nowDate.year, nowDate.month, nowDate.day + 31);
    var format = DateFormat('yyyy-MM-dd');
    var timeformat = DateFormat('HH:mm');
    String currentDate = format.format(nowDate);
    String oneMonthDate = format.format(thirtydaysDate);
    String currentTime = timeformat.format(nowDate);
    String finalstartDate = "${currentDate}T$currentTime:00-08:00";
    String finalendDate = "${oneMonthDate}T00:00:00-08:00";
    // print(currentDate);
    // print(oneMonthDate);
    // print(currentTime);
    // print(finalstartDate);
    // print(finalendDate);
    var url = Uri.parse(
        'https://graph.microsoft.com/v1.0/users/$serviceId/calendar/calendarView?startDateTime=$finalstartDate&endDateTime=$finalendDate');
        // 'https://graph.microsoft.com/v1.0/users/GatesFamilyOffice@27r4l5.onmicrosoft.com/calendar/calendarView?startDateTime=2023-01-17T00:00:00-08:00&endDateTime=2023-01-19T19:00:00-08:00');
       // 'https://graph.microsoft.com/v1.0/users/kishan@27r4l5.onmicrosoft.com/calendar/calendarView?startDateTime=2023-01-22T13:45:00-08:00&endDateTime=2023-02-24T00:00:00-08:00');
    print("URL->"+url.toString());
    final response =
        await http.get(url, headers: {"Authorization": "Bearer " + acsToken});

    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  String getFormattedMessage(int index) {
    DateFormat formatter_display_date = DateFormat('MM-dd-yyyy');
    DateFormat formatter_display_time = DateFormat('hh:mm a');

    DateTime tempDateTime = new DateFormat("yyyy-MM-dd'T'hh:mm:ss.sssZ")
        .parse(resp['value'][index]['start']['dateTime'].toString(), true);
    var strDate = formatter_display_date.format(tempDateTime);
    var strTime = formatter_display_time.format(tempDateTime.toLocal());
    var strTimeZone = resp['value'][index]['start']['timeZone'].toString();
    var strBankerName =
        resp['value'][index]['attendees'][0]['emailAddress']['name'].toString();

    var strResponse = strDate +
        ' at ' +
        strTime +
        /*" " +
        strTimeZone +*/
        ' with ' +
        strBankerName;

    return strResponse.toString();
  }

  Widget customButton(double heightButton, String strLabel, Color bgColorButton,
          Color borderColorButton, Color iconTextColor) =>
      Container(
        height: heightButton,
        margin: const EdgeInsets.only(bottom: spacing_14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: borderColorButton, width: 1),
          color: bgColorButton,
        ),
        padding: const EdgeInsets.symmetric(horizontal: spacing_18),
        child: Center(
          child: CustomText(
              textName: strLabel,
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              textColor: iconTextColor),
        ),
      );
}

class CustomButtonNew extends StatelessWidget {
  CustomButtonNew({
    // required this.onPress,
    required this.heightButton,
    required this.strLabel,
    required this.bgColorButton,
    required this.borderColorButton,
    required this.iconTextColor,
  });

  // final Function onPress;
  final double heightButton;
  final String strLabel;
  final Color bgColorButton;
  final Color borderColorButton;
  final Color iconTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColor.brown_231d18, width: 1),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Center(
        child: CustomText(
            textName: Constants.joinMeeting,
            textAlign: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: AppColor.brown_231d18),
      ),
    );
  }
}
