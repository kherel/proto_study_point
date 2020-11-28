import 'package:flutter/material.dart';

class BrandDivider extends StatelessWidget {
  const BrandDivider({
    Key key,
    this.padding,
    this.color = Colors.grey,
    this.isVertical = false,
  }) : super(key: key);

  final EdgeInsets padding;
  final Color color;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      height: isVertical ? null : 1,
      width: isVertical ? 1 : null,
      color: color,
    );
  }
}
