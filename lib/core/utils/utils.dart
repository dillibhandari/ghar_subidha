// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ghar_subidha/core/theme/theme_config.dart';
import 'package:intl/intl.dart';
import 'dimens.dart';
import 'dart:ui' as ui;

// ignore: deprecated_member_use
MediaQueryData mediaQueryData = MediaQueryData.fromView(ui.window);
const num DESIGN_WIDTH = 375;
const num DESIGN_HEIGHT = 812;
const num DESIGN_STATUS_BAR = 0;

class Utils {
  static double getScalingFactor(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return scalingFactor_800sw;
    } else if (width >= 600) {
      return scalingFactor600sw;
    } else if (width < 600 && width > 320) {
      return scalingFactorDefault;
    } else {
      return scalingFactor_320sw;
    }
  }

  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  ///This method is used to get device viewport width.
  get width {
    return mediaQueryData.size.width;
  }

  get height {
    return mediaQueryData.size.height;
  }

  ///This method is used to get device viewport height.
  get _height {
    num statusBar = mediaQueryData.viewPadding.top;
    num bottomBar = mediaQueryData.viewPadding.bottom;
    num screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
    return screenHeight;
  }

  ///This method is used to set padding/margin (for the left and Right side) & width of the screen or widget according to the Viewport width.
  double getHorizontalSize(double px) {
    return ((px * width) / DESIGN_WIDTH);
  }

  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  double getVerticalSize(double px) {
    return ((px * _height) / (DESIGN_HEIGHT - DESIGN_STATUS_BAR));
  }

  ///This method is used to set smallest px in image height and width
  double getSize(double px) {
    var height = getVerticalSize(px);
    var width = getHorizontalSize(px);
    if (height < width) {
      return height.toDoubleValue();
    } else {
      return width.toDoubleValue();
    }
  }

  double setSize(double size, BuildContext context) {
    return size * getScalingFactor(context);
  }

  ///This method is used to set text font size according to Viewport
  double getFontSize(double px) {
    return getSize(px);
  }

  ///This method is used to set padding responsively
  EdgeInsets getPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return getMarginOrPadding(
      all: all,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  ///This method is used to set margin responsively
  EdgeInsets getMargin({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return getMarginOrPadding(
      all: all,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  ///This method is used to get padding or margin responsively
  EdgeInsets getMarginOrPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: getHorizontalSize(
        left ?? 0,
      ),
      top: getVerticalSize(
        top ?? 0,
      ),
      right: getHorizontalSize(
        right ?? 0,
      ),
      bottom: getVerticalSize(
        bottom ?? 0,
      ),
    );
  }

  Future<dynamic> showBottomSheet(BuildContext context, Widget child) {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      barrierColor: AppColors.filterBack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusX10 * Utils.getScalingFactor(context)),
          topRight:
              Radius.circular(radiusX10 * Utils.getScalingFactor(context)),
        ),
      ),
      builder: (context) {
        return child;
      },
    );
  }

  static String? validate(String? value, {field}) {
    value ??= "";
    if (value.isEmpty) {
      if (field == "email") {
        return 'Please enter your email address.';
      } else if (field == "password") {
        return 'Please enter you password.';
      } else if (field == "location") {
        return 'Please enter location';
      } else if (field == "current_password") {
        return 'Please enter your current password.';
      } else if (field == "new_password") {
        return 'Please enter your new password';
      } else if (field == "confirm_password") {
        return 'Please enter confirm password';
      } else if (field == "gender") {
        return 'Please select your gender';
      } else if (field == "dob") {
        return 'Please enter Date of Birth.';
      } else if (field == "reason_details") {
        return "Please enter reason details";
      }
    } else {
      if (field == "password") {
        if (value.length < 6) {
          return "Password must be at least 6 characters";
        }
      }
    }
    return null;
  }

  List<DateTime> startAndEndDate(String dateRange) {
    DateTime startDate;
    DateTime endDate;
    if (dateRange == "") {
      startDate = DateTime.now();
      endDate = startDate.add(const Duration(days: 1));
    } else {
      List<String> dateStrings = dateRange.split(" - ");
      startDate = DateFormat("dd/MM/yyyy").parse(dateStrings[0]);
      endDate = DateFormat("dd/MM/yyyy").parse(dateStrings[1]);
    }
    return [startDate, endDate];
  }
}

extension FormatExtension on double {
  /// Return a [double] value with formatted according to provided fractionDigits
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
