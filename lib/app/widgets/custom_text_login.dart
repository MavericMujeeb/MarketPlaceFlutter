import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextLogin extends StatelessWidget {
  final String textName;
  final TextAlign  textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  const CustomTextLogin({Key? key, required this.textName, required this.textAlign, required this.fontSize, required this.fontWeight, required this.textColor}) : super(key: key);

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
