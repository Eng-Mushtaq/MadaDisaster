import 'package:flutter/material.dart';
import 'package:red_zone/utils/constants/colors.dart';
import 'package:red_zone/utils/constants/sizes.dart';

class TRoundedContainer extends StatelessWidget {
  final double? width, height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final Color boarderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const TRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = TSizes.cardRadiusLg,
    this.boarderColor = TColors.white,
    this.backgroundColor = TColors.borderPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: boarderColor) : null,
      ),
      child: child,
    );
  }
}
