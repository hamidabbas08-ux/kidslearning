import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isTablet(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }

  static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    return isTablet(context) ? baseFontSize * 1.4 : baseFontSize;
  }

  static double getResponsiveWidgetWidth(BuildContext context, double baseWidth) {
    return isTablet(context) ? baseWidth * 1.5 : baseWidth;
  }
}
