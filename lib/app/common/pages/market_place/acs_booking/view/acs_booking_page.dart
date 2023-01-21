import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/market_place/acs_booking/controller/acs_booking_controller.dart';
import 'package:marketplace/app/common/pages/market_place/acs_booking/view/phone/acs_booking_phone_page.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/controller/acs_chat_calling_controller.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/view/phone/acs_chat_calling_phone_page.dart';
import 'package:marketplace/app/common/pages/market_place/acs_contact/view/phone/acs_contact_phone_page.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/controller/product_details_controller.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/view/phone/product_details_phone_page.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';
// import 'package:marketplace/data/repositories/acs_chat_calling_repository.dart';
import 'package:marketplace/data/repositories/data_product_repository.dart';


class ACSBookingPage extends View{
  const ACSBookingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ACSBookingPageState();
  }
}

class ACSBookingPageState extends ResponsiveViewState<ACSBookingPage, ACSBookingController>{

  ACSBookingPageState() : super(ACSBookingController(ACSChatCallingDataRepository()));

  @override
  Widget get desktopView => const ACSBookingPhonePage();

  @override
  Widget get mobileView => const ACSBookingPhonePage();

  @override
  Widget get tabletView => const ACSBookingPhonePage();

  @override
  Widget get watchView => const ACSBookingPhonePage();

}