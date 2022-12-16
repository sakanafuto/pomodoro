// Flutter imports:
import 'package:flutter/material.dart';

class SizeRoute extends PageRouteBuilder<Route<dynamic>> {
  SizeRoute({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return Align(
              child: SizeTransition(sizeFactor: animation, child: child),
            );
          },
        );

  final Widget page;
}
