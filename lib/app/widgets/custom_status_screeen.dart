import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_button.dart';
import 'package:marketplace/app/widgets/custom_text.dart';

class CustomStatusScreen extends StatefulWidget{

  final Icon statusIcon;
  final String statusText;
  final String buttonTitle;
  final Function buttonCallBack;

  const CustomStatusScreen({required this.statusIcon, required this.statusText, required this.buttonTitle, required this.buttonCallBack ,Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CustomStatusScreenState();
  }
}

class CustomStatusScreenState extends State<CustomStatusScreen>{

  actionButton(context){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom:60),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
              buttonName: Text(widget.buttonTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
              borderColor: AppColor.blue_color,
              fillColor: AppColor.white_color,
              textColor: AppColor.blue_color,
              height: 50,
              width: double.infinity,
              onTapAction: ()=> widget.buttonCallBack()
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: AppColor.green_color_100
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColor.green_color,
                  size: 70,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomText(
                    textName:widget.statusText,
                    textAlign: TextAlign.center,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    textColor: AppColor.black_color),
              ),
              actionButton(context)
            ],
          ),
        ),
      ),
    );
  }
}