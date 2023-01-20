import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_js/flutter_js.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/common/utils/javascript_services.dart';
import 'package:marketplace/app/widgets/custom_badge.dart';
import 'package:marketplace/app/widgets/custom_gradient_container.dart';
import 'package:marketplace/data/helpers/shared_preferences.dart';

class CustomAppCard extends StatelessWidget {
  final String productImagePath;
  final String productTitle;
  final String productPopularity;
  final String productStatus;
  final Color statusColor;
  final Color statusTextColor;
  Function? detailActionCallBack;

  CustomAppCard(Key? key,
      {required this.productImagePath,
      required this.productTitle,
      required this.productPopularity,
      required this.productStatus,
      required this.statusColor,
      required this.statusTextColor,
      this.detailActionCallBack})
      : super(key: key);

  final box = GetStorage();

  Widget get productImageWidget => SizedBox(
        height: 120.0,
        // width: 200.0,
        child: Center(
          child: Image.asset(
            productImagePath,
          ),
        ),
      );

  Widget get statusTextWidget => Text(
        productPopularity,
        maxLines: 2,
        style: const TextStyle(
            color: Color(0xFF22303E),
            fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300,
            fontSize: 12,
            overflow: TextOverflow.ellipsis),
      );

  Widget get statusBadge => CustomBadge(null, productStatus, statusColor, statusTextColor, 20, 75);

  Widget get productTitleWidget => Padding(
        padding: const EdgeInsets.only(top: 0.0, left: 10.0),
        child: Text(
          productTitle,
          style: const TextStyle(
            color: Color(0xFF22303E),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      );

  Widget get productStatusWidget => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Expanded(child: statusTextWidget), statusBadge],
        ),
      );

  gotoDetailPage(context) async{

    /*final JavascriptRuntime jsRuntime = getJavascriptRuntime();
    // final number = ValueNotifier(0);

    try{
      final result = await addFromJs(jsRuntime, Resources.number,1);
      Resources.number = result;
    }on PlatformException
    catch(e){
      print('error: ${e.details}');
    }*/

    if (detailActionCallBack != null) {
      Future.delayed(const Duration(microseconds: 500), () {
        navigateToProductDetailScreen(context);
        detailActionCallBack!();
      });
    } else {
      Future.delayed(const Duration(microseconds: 500), () {
        navigateToProductDetailScreen(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      height: 190,
      child: Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: GradientContainer(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color1: AppColor.white_color,
            color2: AppColor.white_color,
            borderColor: AppColor.white_color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productImageWidget,
                productStatusWidget,
                productTitleWidget,
              ],
            ),
            onPressed: () => productTitle == 'Addepar' ? gotoDetailPage(context) : null,
          ),
        ),
      ),
    );
  }
}

/*Future<int> addFromJs(JavascriptRuntime jsRuntime, int firstNumber, int secondNumber) async {
  String blockJs = await rootBundle.loadString("assets/addition.js");
  final jsResult = jsRuntime.evaluate("""${blockJs}add($firstNumber,$secondNumber)""");
  final jsStringResult = jsResult.stringResult;
  AppSharedPreference().addString(key:SharedPrefKey.page_count.toString(), value: jsResult.stringResult);
  print("Details screen open count: "+jsStringResult);
  return int.parse(jsStringResult);
}*/
