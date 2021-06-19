import 'package:flutter/material.dart';

displaySuccessSnackbar(BuildContext context, String text) {
  displaySnackBar(context, text, Colors.green);
}

displayErrorSnackbar(BuildContext context, String text) {
  displaySnackBar(context, text, Colors.red);
}

displaySnackBar(BuildContext context, String text, Color color) {
  final SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
