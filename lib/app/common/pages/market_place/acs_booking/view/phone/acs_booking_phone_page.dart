import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

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

  ACSBookingController? acsBookingController =
      ACSBookingController(ACSChatCallingDataRepository());

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

  final List<bool> _selected = List.generate(100, (i) => false);
  // late final List<bool> _selected;
  late final List<bool> _selectedBanker;

  // var resp;
  // var respBooking;
  var getScheduleResponse;
  var availableTimeSlots;
  var ascToken = '';
  var serviceId = '';
  DateTime today = new DateTime.now();

  int selectedDayIndex = 0;

  // bool inProgress = false;

  List<String> timeslots = [];
  var splitTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // DateTime today = new DateTime.now();
    // DateTime date = new DateTime(today.year, today.month, today.day);

    // getAwailableSlots(today.weekday - 1);


    // acsBookingController?.getAwailableSlots(today.weekday - 1);
    /*setState(() {

    });*/

    getBankersList();
    // getAppoinments(today.weekday - 1);
  }

  void getBankersList() async {
    await acsBookingController?.getBankersList();
    _selectedBanker = List.generate(
        acsBookingController!.respGetBanker['value'].length, (i) => false);
    _selectedBanker[0] = true;
    acsBookingController!.selectedBankerEmailId = acsBookingController!
        .respGetBanker['value'][0]['emailAddress']
        .toString();
    acsBookingController!.selectedBankerId = acsBookingController!
        .respGetBanker['value'][0]['id']
        .toString();

    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    acsBookingController!.defaultDate = formattedDate;
    getAppoinments(today.weekday - 1, formattedDate);

    setState(() {});
  }

  getAppoinments(int weekday, String date) async {
    getScheduleResponse = await acsBookingController?.getAwailableSlots(weekday, date);
    // _selected = List.generate(timeslots.length, (i) => false);
    //_selected[0] = true;
    availableTimeSlots = getScheduleResponse['value'] != null &&
        getScheduleResponse['value'].length > 0 &&
        getScheduleResponse['value'][0]['availabilityView'] != null
        ? getScheduleResponse['value'][0]['availabilityView'].split('')
        : "000000000".split('');
    var startWorkingHr = getScheduleResponse['value'] != null &&
        getScheduleResponse['value'].length > 0 &&
        getScheduleResponse['value'][0]['workingHours'] != null &&
        getScheduleResponse['value'][0]['workingHours']['startTime'] != null
        ? getScheduleResponse['value'][0]['workingHours']['startTime']
        : "08:00:00.0000000";
    var endWorkingHr = getScheduleResponse['value'] != null &&
        getScheduleResponse['value'].length > 0 &&
        getScheduleResponse['value'][0]['workingHours'] != null &&
        getScheduleResponse['value'][0]['workingHours']['endTime'] != null
        ? getScheduleResponse['value'][0]['workingHours']['endTime']
        : "17:00:00.0000000";

    timeslots = acsBookingController!
        .getTimeSlotsToDisplay(startWorkingHr, endWorkingHr);

    var parts = timeslots[0].split('-');
    acsBookingController!.pickedStartTime = parts[0].trim();
    acsBookingController!.pickedEndTime = parts[1].trim();
    refreshTimeSlotsUI(-1);
    setState(() {});
  }

  bookAnAppointment() async {
    await acsBookingController!.actionBookAppointment();
    setState(() {});
    //popScreen(context);
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
                    containerBankerList(),
                    vSpacer(spacing_12),
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
              visible:
                  acsBookingController!.inProgressFullScreen ? true : false,
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
  }

  Widget bottomBookingButton() => GestureDetector(
        onTap: () {
          bookAnAppointment();
          setState(() {});
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
                    selectedDayIndex = value.weekday - 1;

                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(value);

                    // _selected.clear();
                    // _selected = List.generate(acsBookingController!.resp['value'][0]['availabilityView'].length, (i) => false);

                    acsBookingController!.defaultDate = formattedDate;

                    getAppoinments(selectedDayIndex, formattedDate);
                    setState(() {});
                  }),
            ],
          ),
        ),
      );

  Widget containerBankerList() => acsBookingController!.respGetBanker != null &&
          acsBookingController!.respGetBanker['value'].length > 0
      ? listBankers()
      : SizedBox(
          height: 100,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );

  Widget listBankers() => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      // itemCount: 10,
      itemCount: acsBookingController!.respGetBanker['value'].length,
      itemBuilder: (BuildContext context, int index) {
        return bankerListCell(index);
      });

  Widget bankerListCell(int index) => GestureDetector(
        onTap: () {
          for (int i = 0; i < _selectedBanker.length; i++) {
            _selectedBanker[i] = false;
          }
          _selectedBanker[index] = true;
          acsBookingController!.selectedBankerEmailId = acsBookingController!
              .respGetBanker['value'][index]['emailAddress']
              .toString();
          acsBookingController!.selectedBankerId = acsBookingController!
              .respGetBanker['value'][index]['id']
              .toString();

          getAppoinments(today.weekday - 1, acsBookingController!.defaultDate);
          setState(() {});
        },
        child: Card(
          color: Colors.white,
          elevation: 2.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(spacing_14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.asset(
                        Resources.banker_img,
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    hSpacer(spacing_12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            textName: acsBookingController!
                                .respGetBanker['value'][index]['displayName']
                                .toString(),
                            textAlign: TextAlign.start,
                            fontSize: 15,
                            fontWeight: FontWeight.w300),
                        vSpacer(spacing_4),
                        CustomText(
                            textName: 'Available',
                            textAlign: TextAlign.start,
                            fontSize: 11,
                            fontWeight: FontWeight.w200),
                      ],
                    ),
                  ],
                ),
                Icon(
                  _selectedBanker[index]
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked_rounded,
                  color: _selectedBanker[index] ? Colors.green : Colors.black,
                ),
              ],
            ),
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
              acsBookingController!.inProgress
                  ? SizedBox(
                      height: 100,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : acsBookingController!.resp != null &&
                          acsBookingController!
                                  .resp['value'][0]['availabilityView'].length >
                              0
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
      // itemCount: acsBookingController!.resp['value'][0]['availabilityView'].toString().length,
      itemCount: timeslots.length,
      itemBuilder: (BuildContext context, int index) {
        return slotCellItem(index);
      });

  Widget slotCellItem(int index) => GestureDetector(
        onTap: () => {
          if(int.parse(availableTimeSlots[index])!=0) {
          //Handle event for time slots not available
          } else {
            //Handle event for time slots available
              refreshTimeSlotsUI(index),
              splitTime = timeslots[0].split('-'),
              acsBookingController!.pickedStartTime = splitTime[0].trim(),
              acsBookingController!.pickedEndTime = splitTime[1].trim(),
            }
        },
        child: Card(
          color: availableTimeSlots != null
              && availableTimeSlots.length > 0
              && int.parse(availableTimeSlots[index])!=0
              ? AppColor.grey_color_300 : _selected[index]
              ? AppColor.brown_231d18
              : Colors.white,
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
              textName: timeslots[index],
              // textName: displayTimeSlot(index),
              textAlign: TextAlign.center,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              textColor: availableTimeSlots != null
                  && availableTimeSlots.length >0
                  && int.parse(availableTimeSlots[index])!=0
                  ? Colors.black
                  : _selected[index]
                  ? Colors.white
                  : Colors.black,
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

  displayTimeSlot(int index) {
    var respStartTime = acsBookingController!.resp['value'][0]['workingHours']
            [selectedDayIndex]['timeSlots'][index]['startTime']
        .toString();
    var respEndTime = acsBookingController!.resp['value'][0]['workingHours']
            [selectedDayIndex]['timeSlots'][index]['endTime']
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

  void refreshTimeSlotsUI(int index) {
    for (int i = 0; i < 10; i++) {
      setState(() => _selected[i] = false);
    }
    if (index >= 0) {
      setState(() => _selected[index] = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return view;
  }
}
