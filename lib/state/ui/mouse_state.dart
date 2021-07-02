import 'package:flutter/material.dart';

class MouseState extends ChangeNotifier {
  MouseCursor _cursor;
  Offset _position = Offset.zero;
  bool _isPresent = true;

  MouseState([this._cursor = MouseCursor.defer]);

  MouseCursor get cursor => _cursor;
  Offset get position => _position;
  bool get isPresent => _isPresent;

  set cursor(MouseCursor value) {
    _cursor = value;
    notifyListeners();
  }

  set position(Offset value) {
    _position = value;
    notifyListeners();
  }

  set isPresent(bool value) {
    _isPresent = value;
    notifyListeners();
  }
}
