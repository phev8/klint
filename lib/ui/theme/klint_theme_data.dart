import 'package:flutter/material.dart';

class KlintThemeData {
  static final successColor = Colors.green.shade800;
  static const errorColor = Colors.red;
  static final menuBackgroundColor = Colors.grey.shade800;
  static const overlayColor = Color.fromRGBO(0, 0, 0, 0.2);

  static const menuTitleTextStyle =
      TextStyle(fontSize: 28.0, height: 1.0, color: Colors.grey, fontWeight: FontWeight.bold);
  static const menuSectionTextStyle =
      TextStyle(fontSize: 16.0, height: 1.0, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: .5);
  static const tileTitleTextStyle = TextStyle(fontSize: 14.0);
  static const snackBarTextStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);

  static const double defaultSpacing = 8.0;

  static const double contextMenuWidth = 220.0;
  static const double contextMenuPadding = defaultSpacing * 1.5;

  static const tileTitleOffset = Offset(-16, 0);
  static const double tileItemHeight = 42.0;

  static final guideLinePaint = Paint()..color = Colors.grey.shade400;

  static const defaultAspectRatioWidth = 16.0;
  static const defaultAspectRatioHeight = 9.0;

  static final ThemeData materialTheme = ThemeData(
    brightness: Brightness.dark,
    toggleableActiveColor: Colors.grey.shade300,
    canvasColor: Colors.grey.shade700,
    checkboxTheme: CheckboxThemeData(checkColor: MaterialStateProperty.all(menuBackgroundColor)),
  );
}
