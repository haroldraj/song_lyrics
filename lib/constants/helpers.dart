import 'package:flutter/material.dart';

class Helpers {
  static void goTo(BuildContext context, Widget screen,
      {bool isReplaced = false}) {
    isReplaced
        ? Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => screen))
        : Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }
}

class Spacing {
  static Widget vertical = const SizedBox(height: 15);
  static Widget horizontal = const SizedBox(width: 15);
}
