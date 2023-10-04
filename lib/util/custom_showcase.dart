import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcaseWidget extends StatelessWidget {

  final Widget child;
  final String description;
  final GlobalKey globalKey;
  final double borderRadius;

  const CustomShowcaseWidget({
    super.key,
    required this.child,
    required this.description,
    required this.globalKey,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Showcase(
        key: globalKey,
        // decoration
        targetBorderRadius: BorderRadius.circular(borderRadius),
        tooltipBackgroundColor: Colors.pink,
        tooltipPadding: EdgeInsets.all(12.0),
        descTextStyle: TextStyle(
          color: Colors.white,
        ),
        description: description,
        child: child,
    );
  }
}
