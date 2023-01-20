import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';
import 'package:marketplace/app/widgets/custom_tab_bar_controller.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> tabHeaderList;
  final List<Widget> tabContentList;
  final int tabLength;
  const CustomTabBar({
    Key? key,
    required this.tabHeaderList,
    required this.tabContentList,
    required this.tabLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabLength,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomTabBarController(
            tabs: tabHeaderList,
            unselectedLabelStyle: TextStyle(
              color: AppColor.blue_color_900,
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColor.white_color
            ),
            unselectedBackgroundColor: AppColor.white_color,
            decoration: BoxDecoration(
              color: AppColor.blue_color_900,
              borderRadius: const BorderRadius.all(Radius.circular(30))
            ),
          ),
          Expanded(
            child: TabBarView(
              children: tabContentList,
            ),
          ),
        ],
      ),
    );
  }
}
