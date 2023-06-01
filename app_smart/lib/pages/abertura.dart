import 'package:flutter/material.dart';

class PageTransition extends PageRouteBuilder {
  final Widget currentPage;
  final Widget nextPage;

  PageTransition({required this.currentPage, required this.nextPage})
      : super(
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return currentPage;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      return Stack(
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: Offset(-1.0, 0.0),
            ).animate(animation),
            child: currentPage,
          ),
          SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: nextPage,
          ),
        ],
      );
    },
  );
}
