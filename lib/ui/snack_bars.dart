import 'package:flutter/material.dart';
import 'package:klint/ui/theme/klint_theme_data.dart';

displaySuccessSnackbar(BuildContext context, String text) {
  displaySnackBar(context, text, KlintThemeData.successColor);
}

displayErrorSnackbar(BuildContext context, String text) {
  displaySnackBar(context, text, KlintThemeData.errorColor);
}

displaySnackBar(BuildContext context, String text, [Color? color]) {
  final SnackBar snackBar = SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: KlintThemeData.snackBarTextStyle,
    ),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
