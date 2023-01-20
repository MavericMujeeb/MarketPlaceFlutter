import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/navigation/navigation.dart';
import 'package:marketplace/app/widgets/custom_app_card.dart';
import 'package:marketplace/app/widgets/custom_badge.dart';
import 'package:marketplace/app/widgets/custom_button.dart';
import 'package:marketplace/data/repositories/data_product_repository.dart';
import 'package:marketplace/domain/entities/product_dao.dart';
import '../../../../../../widgets/custom_alert_dialog.dart';
import '../../../../../../widgets/custom_text.dart';
import '../../../../../utils/constants.dart';
import '../../controller/product_details_controller.dart';

class ProductDetailsPhonePage extends View {
  const ProductDetailsPhonePage({Key? key}) : super(key: key);

  @override
  ProductDetailsPhonePageState createState() => ProductDetailsPhonePageState();
}

class ProductDetailsPhonePageState extends ViewState<ProductDetailsPhonePage, ProductDetailsController> {
  ProductDetailsPhonePageState() : super(ProductDetailsController(ProductDataRepository()));

  ProductDetailsController? productDetailsController;

  Widget get keyPointIcon => Container(
        height: 21,
        width: 21,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: AppColor.green_color_50),
        child: const Center(
          child: Icon(
            Icons.check,
            size: 18,
            color: AppColor.teal_color,
          ),
        ),
      );

  Widget keyPointText(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CustomText(
            textName: text,
            textAlign: TextAlign.start,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            textColor: AppColor.black_color),
      ),
    );
  }

  Widget keyPointWidget(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          keyPointIcon,
          keyPointText(text),
        ],
      ),
    );
  }

  Widget buildKeyPointWidgets(ProductDao productData) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: productData.keyPoints.length,
      itemBuilder: (BuildContext context, int index) {
        return keyPointWidget(productData.keyPoints[index]);
      },
    );
  }

  Widget get actionButtons => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: CustomButton(
                onTapAction: () => integrateAction(context),
                buttonName: const Text(Constants.integrate_now),
                borderColor: AppColor.blue_color,
                fillColor: AppColor.blue_color,
                textColor: AppColor.white_color,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 40,
              child: CustomButton(
                onTapAction: () {},
                buttonName: const Text(Constants.speak_to_banker),
                borderColor: AppColor.blue_color,
                fillColor: AppColor.grey_color_200,
                textColor: AppColor.blue_color,
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      );

  Widget suggestedApps(ProductDetailsController controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7.0, left: 15.0),
            child: CustomText(
              textName: Constants.product_details_cards_heading,
              textAlign: TextAlign.start,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: AppColor.black_color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, position) {
                  ProductDao dao = controller.similarApps[position];
                  return CustomAppCard(
                    null,
                    productImagePath: dao.imagePath,
                    productTitle: dao.name,
                    productPopularity: dao.subtitle,
                    productStatus: dao.status,
                    statusColor: controller.getStatusContainerColor(dao.status),
                    statusTextColor: controller.getStatusTextColor(dao.status),
                  );
                },
                itemCount: controller.similarApps.length,
              ),
            ),
          ),
        ],
      );

  Widget appDetailsCard(ProductDao productData) => Card(
        margin: const EdgeInsets.all(15.0),
        elevation: 5,
        color: AppColor.white_color,
        clipBehavior: Clip.hardEdge,
        shadowColor: AppColor.white_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBadge(null, productData.status, AppColor.container_color,
                  AppColor.text_color, 20, 65),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      textName: productData.name,
                      textAlign: TextAlign.start,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.black_color),
                  Image.asset(Resources.addaper_icon_img,
                      height: 30, width: 30, color: AppColor.black_color),
                ],
              ),
              Center(
                child: Image.asset(productData.imagePath,
                    height: 200, width: 200, color: AppColor.black_color),
              ),
              CustomText(
                  textName: Constants.overview,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textColor: AppColor.black_color),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  textName: productData.subtitle,
                  textAlign: TextAlign.justify,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  textColor: AppColor.black_color),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  textName: productData.description,
                  textAlign: TextAlign.left,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  textColor: AppColor.grey_color),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                  textName: Constants.key_features,
                  textAlign: TextAlign.start,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  textColor: AppColor.black_color),
              const SizedBox(height: 10),
              buildKeyPointWidgets(productData)
            ],
          ),
        ),
      );

  Future<void> integrateAction(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return CustomAlertDialogWidget(
            title: Constants.customAlertDialogTitle,
            description: Constants.customAlertDialogDescription,
            cancelButtonName: Constants.customAlertDialogCancelButtonName,
            confirmButtonName: Constants.customAlertDialogConfirmButtonName,
            cancelActionCallBack: () {
              popScreen(context);
            },
            confirmActionCallBack: () {
              //pop dialog and proceed
              popScreen(context);
              navigateToProductIntegrationProcessScreen(context, 'Addepar');
            },
          );
        });
  }

  @override
  Widget get view => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.transparent_color,
          leading: IconButton(
              onPressed: () => popScreen(context),
              icon: const Icon(Icons.chevron_left)),
        ),
        key: globalKey,
        body: SafeArea(
          child: ControlledWidgetBuilder<ProductDetailsController>(
            builder: (context, controller) {
              ProductDao productData = controller.productAddepar;
              productDetailsController = controller;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appDetailsCard(productData),
                    suggestedApps(controller),
                    actionButtons,
                  ],
                ),
              );
            },
          ),
        ),
      );
}
