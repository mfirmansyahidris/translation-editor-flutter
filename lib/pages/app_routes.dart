import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class AppRoutes {
  static const String splash = "/";
  static const String main = "/main";
  

  static Map<String, WidgetBuilder> getRoutes({RouteSettings? routeSettings}) => {
    splash: (context) => const SplashScreen(),
    main: (context) => const MainScreen()
  };
}

enum PageTransition {
  stack, slide
}