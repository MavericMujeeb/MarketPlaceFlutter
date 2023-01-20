import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color borderColor;
  final Widget child;
  final VoidCallback? onPressed;
  final double height;
  final double width;
  final double? radius;
  final double? borderWidth;

  const GradientContainer({
    Key? key,
    required this.child,
    required this.color1,
    required this.color2,
    required this.borderColor,
    required this.onPressed,
    required this.height,
    required this.width,
    this.radius,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              color1,
              color2,
            ],
          ),
          border: Border.all(
            color: borderColor,
            width: (borderWidth != null ? borderWidth! : 1.0),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius != null ? radius! : 16),
          ),
        ),
        child: child,
      ),
    );
  }
}
