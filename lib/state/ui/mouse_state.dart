import 'package:flutter/material.dart';

class MouseState extends ChangeNotifier {
  MouseCursor _cursor = SystemMouseCursors.precise;
  Offset _position = Offset.zero;
  bool _isPresent = true;

  MouseState();

  MouseCursor get cursor => _cursor;
  Offset get position => _position;
  bool get isPresent => _isPresent;

  set cursor(MouseCursor value) {
    if (value != _cursor) {
      _cursor = value;
      notifyListeners();
    }
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
