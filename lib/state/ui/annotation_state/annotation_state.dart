import 'package:flutter/material.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';

class AnnotationState extends ChangeNotifier {
  AnnotationMode _mode = AnnotationMode.NONE;

  AnnotationMode get mode => _mode;

  set mode(AnnotationMode value) {
    _mode = value;
    notifyListeners();
  }

  toggleMode(AnnotationMode value) {
    _mode = _mode == value ? AnnotationMode.NONE : value;
    notifyListeners();
  }
}
