import 'package:flutter/material.dart';

class MouseState extends ChangeNotifier {
  Offset _position = Offset.zero;

  Offset get position => _position;

  set position(Offset value) {
    _position = value;
    notifyListeners();
  }
}
