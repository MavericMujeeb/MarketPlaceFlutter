import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Text buttonName;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double width;
  final Function onTapAction;


//  final Function onPressed;
//  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  const CustomButton(
      {Key? key,
        required this.buttonName,
        required this.borderColor,
        required this.fillColor,
        required this.textColor,
        required this.height,
        required this.width,
        required this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, //height of button
      width: width, //width of button
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            onPrimary: textColor,
            primary: fillColor,
            elevation: 0,
            side: BorderSide(
                width: 1, color: borderColor), //border width and color
            shape: RoundedRectangleBorder(
              //to set border radius to button
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.all(0) //content padding inside button
        ),
        onPressed: () =>
            onTapAction(),

        child: buttonName,
      ),
    );
  }
}
