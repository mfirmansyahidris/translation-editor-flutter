import 'package:flutter/material.dart';

class AppNavigator{
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> goToPageReplace<T extends Object?>(
      String route, {
        Object? arguments,
      }) async {
    return await navigatorKey.currentState?.pushReplacementNamed(route, arguments: arguments);
  }

  static Future<T?> goToPageRemoveUntil<T extends Object?>(
      String route, {
        Object? arguments,
      }) async {
    return await navigatorKey.currentState?.pushNamedAndRemoveUntil(route, (route) => false, arguments: arguments);
  }

  static Future<T?> goToPage<T extends Object?>(
      String route, {
        Object? arguments,
      }) async {
    return await navigatorKey.currentState?.pushNamed(route, arguments: arguments);
  }

  static void pop<T extends Object?>([ T? result ]) => navigatorKey.currentState?.pop(result);
  static void popUntil<T extends Object?>(String route) => navigatorKey.currentState?.popUntil((r) => r.settings.name == route);
}