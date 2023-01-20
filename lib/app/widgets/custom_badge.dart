import 'package:flutter/material.dart';
import 'package:marketplace/app/widgets/custom_gradient_container.dart';

class CustomBadge extends StatelessWidget{
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final double paramHeight;
  final double paramWidth;

  const CustomBadge(Key? key, this.title, this.backgroundColor, this.textColor, this.paramHeight, this.paramWidth) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      color1: backgroundColor,
      color2: backgroundColor,
      borderColor: backgroundColor,
      onPressed: () {},
      height: 20,
      width: 65,
      radius: 7,
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}