import 'package:flutter/material.dart';

class SizeConfig {
  // static MediaQueryData _mediaQueryData=MediaQueryData.ofType;
  static double screenWidth = 375;
  static double screenHeight = 812;
  // static double defaultSize;
  // static Orientation orientation;

  void init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    // orientation = _mediaQueryData.orientation;
  }
}

double getProportionateScreenHeight(double inputHeight) {
  final double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

double getProportionateScreenWidth(double inputWidth) {
  final double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}
