import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/pages/market_place/home/view/home_page.dart';
import 'package:marketplace/app/common/pages/market_place/my_apps/view/my_apps_page.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';
// import 'package:marketplace/data/repositories/acs_chat_calling_repository.dart';

import '../../../../../utils/constants.dart';
import '../../controller/acs_chat_calling_controller.dart';

class ACSContactPhonePage extends View {
  const ACSContactPhonePage({Key? key}) : super(key: key);

  @override
  ACSContactPhonePageState createState() => ACSContactPhonePageState();
}

class ACSContactPhonePageState
    extends ViewState<ACSContactPhonePage, ACSContactController> {
  ACSContactPhonePageState()
      : super(ACSContactController(ACSChatCallingDataRepository()));

  ACSContactController? productDetailsController;

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

  Future<void> startCallClick() async {
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
  }

  @override
  Widget get view => Scaffold(
        // backgroundColor: Colors.white70,
        key: globalKey,
        body: SafeArea(
          child: ControlledWidgetBuilder<ACSContactController>(
            builder: (context, controller) {
              productDetailsController = controller;
              return Column(
                children: [
                  horizontalDivider,
                  contentContact,
                ],
              );
            },
          ),
        ),
      );

  Widget get contentContact => Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(spacing_14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                contactsItemCell,
                vSpacer(spacing_12),
                GestureDetector(
                  onTap: () {
                    startCallClick();
                  },
                  child: customButton(
                      const Icon(null, size: 0),
                      Constants.bookAnAppointment,
                      AppColor.brown_231d18,
                      AppColor.brown_231d18,
                      Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    joinCallClick();
                  },
                  child: customButton(
                      Icon(Icons.chat, size: 16, color: AppColor.brown_231d18),
                      Constants.sendMessage,
                      AppColor.bg_color_contact,
                      AppColor.brown_231d18,
                      AppColor.brown_231d18),
                ),
                GestureDetector(
                  onTap: () {
                    chatClick();
                  },
                  child: customButton(
                      Icon(Icons.call, size: 16, color: AppColor.brown_231d18),
                      Constants.startVideoOrAudioCall,
                      AppColor.bg_color_contact,
                      AppColor.brown_231d18,
                      AppColor.brown_231d18),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get horizontalDivider => Container(
        height: 0.5,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: spacing_18),
        color: AppColor.black_color_54,
      );

  Widget get listContacts => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return contactsItemCell;
      });

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
