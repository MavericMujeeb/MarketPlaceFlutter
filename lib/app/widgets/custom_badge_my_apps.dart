import 'package:flutter/material.dart';
import 'package:marketplace/app/widgets/gradient_container.dart';

class CustomBadgeMyApps extends StatelessWidget{
  final String title;
  final Color backgroundColor;
  final Color textColor;

  const CustomBadgeMyApps(Key? key, this.title, this.backgroundColor, this.textColor) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      color1: backgroundColor,
      color2: backgroundColor,
      borderColor: backgroundColor,
      onPressed: () {},
      height: 24,
      width: 80,
      radius: 5,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}