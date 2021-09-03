import 'package:flutter/material.dart';

import 'annotation_state/annotation_mode.dart';

class AnnotationBarState extends ChangeNotifier {
  bool _box = false;
  bool _tags = false;
  bool _save = false;
  bool _delete = false;

  bool get box => _box;
  bool get tags => _tags;
  bool get save => _save;
  bool get delete => _delete;

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

  set delete(bool value) {
    _delete = value;
    notifyListeners();
  }

  setAnnotationMode(AnnotationMode mode) {
    switch (mode) {
      case AnnotationMode.BOX:
        _box = true;
        _delete = false;
        break;

      case AnnotationMode.DELETE:
        _delete = true;
        _box = false;
        break;

      case AnnotationMode.NONE:
        _box = false;
        _delete = false;
        break;
    }
    notifyListeners();
  }
}
