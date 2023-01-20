import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'custom_icon.dart';

class CustomAppBar extends StatelessWidget
    with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final Color bgColor;
  final Color titleColor;

  CustomAppBar(
      this.title,
      { Key ?key,  required this.bgColor, required this.titleColor,}) : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:  const CustomIcon(iconColor: AppColor.blue_color, icon: Icon(Icons.arrow_back_ios),),
      title: Text(
        title,
        style:  TextStyle(color: titleColor),
      ),
      backgroundColor: bgColor,
      automaticallyImplyLeading: true,
    );
  }
}
