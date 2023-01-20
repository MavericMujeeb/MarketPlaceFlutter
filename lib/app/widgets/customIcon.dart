

import 'package:flutter/cupertino.dart';

class CustomIcon extends StatelessWidget {
  final Icon icons;
  final Color iconColor;
  const CustomIcon({ Key ?key, required this.iconColor,  required this.icons, Icon? iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(color: iconColor,icons.icon);
  }

}
