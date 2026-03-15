import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilHelper {
  /// Dynamically calculates `expandedHeight` based on screen size
  static double collapsedHeight({
    double large = 0.265,
    double medium = 0.30,
    double small = 0.34,
  }) {
    double screenHeight = ScreenUtil().screenHeight;

    if (screenHeight > 850) {
      return large.sh; // Large devices (e.g., iPhone 16 Pro Max)
    } else if (screenHeight > 700) {
      return medium.sh; // Medium devices
    } else {
      return small.sh; // Small devices (e.g., iPhone SE)
    }
  }

  static double expanHeight({
    double large = 0.38,
    double medium = 0.41,
    double small = 0.34,
  }) {
    double screenHeight = ScreenUtil().screenHeight;

    if (screenHeight > 850) {
      return large.sh; // Large devices (e.g., iPhone 16 Pro Max)
    } else if (screenHeight > 700) {
      return medium.sh; // Medium devices
    } else {
      return small.sh; // Small devices (e.g., iPhone SE)
    }
  }

  static double fixedSpace({
    double large = 0.23,
    double medium = 0.26,
    double small = 0.36,
  }) {
    double screenHeight = ScreenUtil().screenHeight;

    if (screenHeight > 850) {
      return large.sh; // Large devices (e.g., iPhone 16 Pro Max)
    } else if (screenHeight > 700) {
      return medium.sh; // Medium devices
    } else {
      return small.sh; // Small devices (e.g., iPhone SE)
    }
  }
}
