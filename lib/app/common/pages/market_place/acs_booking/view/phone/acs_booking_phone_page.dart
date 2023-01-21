import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/home/view/home_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/my_apps_page.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';
// import 'package:marketplace/data/repositories/acs_chat_calling_repository.dart';

import '../../../../../utils/constants.dart';
import '../../controller/acs_booking_controller.dart';

class ACSBookingPhonePage extends View {
  const ACSBookingPhonePage({Key? key}) : super(key: key);

  @override
  ACSBookingPhonePageState createState() => ACSBookingPhonePageState();
}

class ACSBookingPhonePageState
    extends ViewState<ACSBookingPhonePage, ACSBookingController> {
  ACSBookingPhonePageState()
      : super(ACSBookingController(ACSChatCallingDataRepository()));

  ACSBookingController? productDetailsController;

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

  final List<int> _list = List.generate(10, (i) => i);
  final List<bool> _selected = List.generate(10, (i) => false);

  @override
  Widget get view => Scaffold(
        // backgroundColor: Colors.white70,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          leading: IconButton(
              onPressed: () => popScreen(context),
              icon: const Icon(Icons.chevron_left)),
          title: appBarTitle,
        ),
        key: globalKey,
        body: SafeArea(
          child: ControlledWidgetBuilder<ACSBookingController>(
            builder: (context, controller) {
              productDetailsController = controller;
              return Column(
                children: [
                  // horizontalDivider,
                  bookingContact,
                ],
              );
            },
          ),
        ),
      );

  Widget get bookingContact => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(spacing_14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // contactsItemCell,
                vSpacer(spacing_12),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        // firstDate: DateTime(1950),
                        firstDate: DateTime.now(),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      // print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                      showToast(formattedDate);
                    } else {}
                  },
                  child: customButton(
                      const Icon(null, size: 0),
                      Constants.selectDate,
                      Colors.white,
                      AppColor.brown_231d18,
                      AppColor.brown_231d18),
                ),
                containerSlot(),
                vSpacer(spacing_12),
                GestureDetector(
                  onTap: () {},
                  child: customButton(
                      const Icon(null, size: 0),
                      Constants.bookAnAppointment,
                      AppColor.brown_231d18,
                      AppColor.brown_231d18,
                      Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  void showToast(String s) {
    final snackBar = SnackBar(
      content: Text(s.toString()),
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget containerSlot() => Card(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: CustomText(
                  textName: Constants.pickTimeSlot,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              vSpacer(10),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return slotCellItem(index);
                  }),
            ],
          ),
        ),
      );

  Widget slotCellItem(int index) => GestureDetector(
        onTap: () => {
          print('Clicked on index: $index'),
          for (int i = 0; i < 10; i++) {setState(() => _selected[i] = false)},
          setState(() => _selected[index] = true)
        },
        child: Card(
          color: _selected[index] ? AppColor.brown_231d18 : Colors.white,
          elevation: 2.0,
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: spacing_8, vertical: spacing_8),
            child: CustomText(
              textName: '01:45 PM - 02:45 PM',
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
            textName: Constants.contactCenterToolbarMsg,
            textAlign: TextAlign.center,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            textColor: AppColor.black_color_54,
          ),
        ],
      );

  Widget get contactsItemCell => Card(
        color: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(spacing_14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  textName: Constants.yourPrivateBanker,
                  textAlign: TextAlign.start,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              vSpacer(spacing_10),
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
                          textName: 'James Lim',
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
            ],
          ),
        ),
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
}
