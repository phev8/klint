import 'package:flutter/material.dart';

class ErrorDialog {
  static Future<Null> display(BuildContext context, String errorText) async {
    return showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: SingleChildScrollView(
              child: Text(errorText),
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
