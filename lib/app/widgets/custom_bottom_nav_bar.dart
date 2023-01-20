import 'package:flutter/material.dart';
import 'package:marketplace/app/common/utils/constants.dart';

class CustomBottomNavBar extends StatelessWidget{

  const CustomBottomNavBar({
    required this.items,
    required this.onTabSelect,
    required this.currentTabIndex,
    Key? key}) : super(key: key);

  final List items;
  final Function onTabSelect;
  final int currentTabIndex;

  get bottomNavBaItems {
    List<BottomNavigationBarItem> bottomNavItems = [];
    for (var i=0; i<items.length; i++) {
      var item = items[i];
      bottomNavItems.add(
        BottomNavigationBarItem(
          icon: Container(
            margin: const EdgeInsets.only(bottom:4) ,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: i == currentTabIndex ? AppColor.bottom_tab_color : AppColor.transparent_color,
            ),
            height: 25,
            width: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:5),
              child: item['icon'],
            ),
          ),
          label: item['label']
        )
      );
    }
    return bottomNavItems;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: currentTabIndex,
      selectedIconTheme: const IconThemeData(
          color: AppColor.white_color
      ),
      selectedItemColor: AppColor.bottom_tab_color,
      unselectedItemColor: AppColor.black_color,
      selectedLabelStyle: const TextStyle(fontSize: 12, color: AppColor.black_color),
      unselectedLabelStyle: const TextStyle(color: AppColor.black_color, fontSize:12),
      elevation: 5,
      onTap: (selectedIndex)=> onTabSelect(selectedIndex),
      items: bottomNavBaItems
    );
  }
}