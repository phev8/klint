import 'package:flutter/material.dart';

class MouseState extends ChangeNotifier {
  Offset _position = Offset.zero;
  bool _isPresent = true;

  Offset get position => _position;
  bool get isPresent => _isPresent;

  set position(Offset value) {
    _position = value;
    notifyListeners();
  }

  set isPresent(bool value) {
    _isPresent = value;
    notifyListeners();
  }
}
