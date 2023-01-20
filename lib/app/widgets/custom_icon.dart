

import 'package:flutter/cupertino.dart';

class CustomIcon extends StatelessWidget {
  final Icon icon;
  final Color iconColor;
  const CustomIcon({ Key ?key, required this.iconColor,  required this.icon, Icon? iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(color: iconColor, icon.icon);
  }

}
