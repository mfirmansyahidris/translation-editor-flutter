import 'package:flutter/material.dart';

class Transition {
  static PageRouteBuilder slide(WidgetBuilder builder, RouteSettings settings){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      settings: settings
    );
  }

  static PageRoute stack(WidgetBuilder builder, RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => builder(context),
      settings: settings,
    );
  }
}