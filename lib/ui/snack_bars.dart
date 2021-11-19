import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

displaySuccessSnackbar(BuildContext context, String text, [Duration duration = const Duration(milliseconds: 1000)]) {
  displaySnackBar(context, text, KlintThemeData.successColor, duration);
}

displayErrorSnackbar(BuildContext context, String text, [Duration duration = const Duration(milliseconds: 4000)]) {
  displaySnackBar(context, text, KlintThemeData.errorColor, duration);
}

displaySnackBar(BuildContext context, String text, [Color? color = Colors.grey, Duration duration = const Duration(milliseconds: 2000)]) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: KlintThemeData.snackBarTextStyle,
    ),
    backgroundColor: color,
    duration: duration,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
