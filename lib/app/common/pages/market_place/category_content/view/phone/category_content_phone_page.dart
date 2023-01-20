import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:marketplace/app/common/pages/market_place/category_content/controller/category_content_controller.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_app_card.dart';
import 'package:marketplace/app/widgets/custom_app_card_new.dart';
import 'package:marketplace/app/widgets/custom_text.dart';
import 'package:marketplace/domain/entities/product_dao.dart';

class CategoryContentPhonePage extends StatefulWidget {

  final String title;
  const CategoryContentPhonePage({Key? key, required this.title}) : super(key: key);

@override
  State<StatefulWidget> createState() {
    return CategoryContentPhonePageState();
  }
}

class CategoryContentPhonePageState extends State<CategoryContentPhonePage> {

  final double cardHeight = 450;

  Widget titleHeaderText(title) => Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0),
        child: CustomText(textName: title, textAlign: TextAlign.start, fontSize: 16, fontWeight: FontWeight.w700, textColor: AppColor.black_color),
      );

  getAppsBySelectedCategory(CategoryContentController controller) {
    List<ProductDao> apps;
    switch (widget.title) {
      case 'All Apps':
        apps = controller.allApps;
        break;
      case 'Tax Solutions':
        apps = controller.topTaxSolutionsList;
        break;
      case 'Grow your wealth':
        apps = controller.topWealthAppsList;
        break;
      case 'Accounting':
        apps = controller.topAccountingAppsList;
        break;
      default:
        apps = controller.allApps;
        break;
    }
    return apps;
  }

  Widget titleHeader(category) {
    String title;
    switch (category) {
      case 'All Apps':
        title = 'Top Apps';
        break;
      case 'Tax Solutions':
        title = 'Top Tax Solution Apps';
        break;
      case 'Grow your wealth':
        title = 'Top Wealth Apps';
        break;
      case 'Accounting':
        title = 'Top Accounting Apps';
        break;
      default:
        title = 'All Apps';
        break;
    }
    return titleHeaderText(title);
  }

  String appPopularityLabel(category) {
    String title;
    switch (category) {
      case 'Tax Solutions':
        title = 'Tax Solutions';
        break;
      case 'Grow your wealth':
        title = 'Wealth';
        break;
      case 'Accounting':
        title = 'Accounting';
        break;
      default:
        title = 'Wealth';
        break;
    }
    return title;
  }

  appListWidget(category, apps, controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: SizedBox(
        // height: cardHeight,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, position) {
            ProductDao dao = apps[position];
            return getListContainer(category, dao.imagePath, dao.name, dao.subtitle, dao.status, controller, context);
          },
          itemCount: apps.length,
        ),
      ),
    );
  }

  Widget getListContainer(
      String category, String imagePath, String name, String subtitle, String status, CategoryContentController controller, BuildContext context) {
    return CustomAppCardNew(
      null,
      productImagePath: imagePath,
      productTitle: name,
      productPopularity: '$subtitle in ${appPopularityLabel(category)}',
      productStatus: status,
      statusColor: controller.getStatusContainerColor(status),
      statusTextColor: controller.getStatusTextColor(status),
      context: context,
    );
  }

  Widget get view => ControlledWidgetBuilder<CategoryContentController>(
    builder: (context, controller) {
      var category = widget.title;
      var apps = getAppsBySelectedCategory(controller);
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 0.0, right: 5.0),
        child: appListWidget(category, apps, controller),
        /*child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // titleHeader(category),
              appListWidget(category, apps, controller),
              // titleHeaderText(Constants.whats_new),
              // appListWidget(category, controller.whatsNewList, controller),
            ],
          ),
        ),*/
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return view;
  }
}
