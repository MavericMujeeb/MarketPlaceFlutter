import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';

class CustomText extends StatelessWidget {
  final String textName;
  final TextAlign  textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  Color? textColor = AppColor.black_color;
  CustomText({Key? key, required this.textName, required this.textAlign, required this.fontSize, required this.fontWeight, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textName,
      textAlign: textAlign,
      style:  TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      )
    );
  }
}
