import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class Dimens{
  static Size get screen {
    BuildContext? context = AppNavigator.navigatorKey.currentContext;
    if(context != null){
      return MediaQuery.of(context).size;
    }
    return const Size(0, 0);
  }

  static double widthInPercent(double percent){
    return screen.width * (percent / 100);
  }
  
  static double heightInPercent(double percent){
    return screen.height * (percent / 100);
  }
  
  static const double spaceXL = 30;
  static const double spaceL = 25;
  static const double spaceDefault = 20;
  static const double spaceS = 15;
  static const double spaceXS = 10;
  static const double spaceXXS = 5;
  static const double spaceXXXS = 3;

  static double borderRadiusS = 5;
  static double borderRadius = 10;
  static double borderRadiusL = 15;

  static double bottomBar = 80;


  static double borderRadiusXL = 30;

  static const Duration durationQuick = Duration(milliseconds: 100);
  static const Duration durationMedium = Duration(milliseconds: 300);

  static const double iconS = 10;
  static const double iconM = 16;
  static const double iconL = 20;
  static const double iconXL = 30;
  static const double iconXXL = 60;
}