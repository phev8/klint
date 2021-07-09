import 'package:flutter/material.dart';

import 'annotation_state/annotation_mode.dart';

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

  setAnnotationMode(AnnotationMode mode) {
    switch (mode) {
      case AnnotationMode.BOX:
        _box = true;
        // set other possible modes to false
        break;
      case AnnotationMode.NONE:
        _box = false;
        break;
    }
    notifyListeners();
  }
}
