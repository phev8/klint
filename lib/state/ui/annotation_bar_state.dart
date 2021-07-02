import 'package:flutter/material.dart';

class AnnotationBarState extends ChangeNotifier {
  bool _box = false;
  bool _tags = false;
  bool _save = false;

  bool get box => _box;
  bool get tags => _tags;
  bool get save => _save;

  set box(bool value) {
    _box = value;
    notifyListeners();
  }

  set tags(bool value) {
    _tags = value;
    notifyListeners();
  }

  set save(bool value) {
    _save = value;
    notifyListeners();
  }
}
