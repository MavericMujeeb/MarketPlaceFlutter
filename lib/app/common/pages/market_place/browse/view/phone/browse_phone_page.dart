import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/browse/controller/browse_controller.dart';
import 'package:marketplace/app/widgets/custom_text.dart';

class BrowseRepository {}

class BrowsePhonePage extends StatefulWidget {
  final String title;
  const BrowsePhonePage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BrowsePhonePageState();
  }
}

class BrowsePhonePageState extends State<BrowsePhonePage> {

  @override
  Widget build(BuildContext context) {
    return view;
  }

  Widget get view => ControlledWidgetBuilder<BrowseController>(
    builder: (context, controller) {
      return Scaffold(
        body: Center(
          child: CustomText(
              textName: "Preference Page",
              textAlign: TextAlign.center,
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      );
    },
  );
}
