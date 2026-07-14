import 'package:flutter/material.dart';
import '../helpers/responsive_helper.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;
  
  bool get isTablet => ResponsiveHelper.isTablet(this);
  
  double responsiveFont(double baseSize) => ResponsiveHelper.getResponsiveFontSize(this, baseSize);
  double responsiveWidth(double baseWidth) => ResponsiveHelper.getResponsiveWidgetWidth(this, baseWidth);
}
