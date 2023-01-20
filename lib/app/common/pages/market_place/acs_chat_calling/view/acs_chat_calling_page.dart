import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/controller/acs_chat_calling_controller.dart';
import 'package:marketplace/app/common/pages/market_place/acs_chat_calling/view/phone/acs_chat_calling_phone_page.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/controller/product_details_controller.dart';
import 'package:marketplace/app/common/pages/market_place/product_details/view/phone/product_details_phone_page.dart';
import 'package:marketplace/data/repositories/acs_chat_calling_repositories.dart';
// import 'package:marketplace/data/repositories/acs_chat_calling_repository.dart';
import 'package:marketplace/data/repositories/data_product_repository.dart';


class ACSChatCallingPage extends View{
  const ACSChatCallingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ACSChatCallingPageState();
  }
}

class ACSChatCallingPageState extends ResponsiveViewState<ACSChatCallingPage, ACSChatCallingController>{

  ACSChatCallingPageState() : super(ACSChatCallingController(ACSChatCallingDataRepository()));

  @override
  Widget get desktopView => const ACSChatCallingPhonePage();

  @override
  Widget get mobileView => const ACSChatCallingPhonePage();

  @override
  Widget get tabletView => const ACSChatCallingPhonePage();

  @override
  Widget get watchView => const ACSChatCallingPhonePage();

}