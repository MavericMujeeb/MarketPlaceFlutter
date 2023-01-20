import 'package:flutter/material.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import '../common/utils/constants.dart';
import 'custom_button.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  const CustomAlertDialogWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.cancelButtonName,
    required this.confirmButtonName,
    required this.cancelActionCallBack,
    required this.confirmActionCallBack
  }) : super(key: key);

  final String title;
  final String description;
  final String cancelButtonName;
  final String confirmButtonName;
  final Function cancelActionCallBack;
  final Function confirmActionCallBack;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)), //this right here
      child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      textName: title,
                      //'Information',
                      textAlign: TextAlign.start,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.blue_color),
                  const SizedBox(height: 5),
                  CustomText(
                      textName: description,
                      //'Do you already have an account?',
                      textAlign: TextAlign.start,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      textColor: AppColor.black_color),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        onTapAction: () => cancelActionCallBack(),
                        buttonName: Text(cancelButtonName),
                        //const Text('No'),
                        borderColor: AppColor.blue_color,
                        fillColor: AppColor.grey_color_200,
                        textColor: AppColor.blue_color,
                        height: 50,
                        width: 120,
                      ),
                      const SizedBox(width: 20,),
                      CustomButton(
                        onTapAction: ()=> confirmActionCallBack(),
                        buttonName: Text(confirmButtonName),
                        //const Text('Yes'),
                        borderColor: AppColor.blue_color,
                        fillColor: AppColor.blue_color,
                        textColor: AppColor.white_color,
                        height: 50,
                        width: 120,
                      ),
                    ],
                  )
                ]),
          )),
    );
  }
}
