import 'package:flutter/material.dart';
import 'package:msq_translation_editor/msq_translation_editor.dart';

class AppRoutes {
  static const String splash = "/";
  static const String initialization = "/initialization";
  static const String main = "/main";
  

  static Map<String, WidgetBuilder> getRoutes({RouteSettings? routeSettings}) => {
    splash: (context) => const SplashScreen(),
    initialization: (context) => const InitializationScreen(),
    main: (context){
      final arguments = routeSettings?.arguments as Map<String, dynamic>?;
      return MainScreen(
        path: arguments?['path'],
        type: arguments?['type'],
      );
    }
  };
}

enum PageTransition {
  stack, slide
}