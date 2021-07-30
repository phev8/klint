import 'package:flutter/material.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';

class AnnotationState extends ChangeNotifier {
  AnnotationMode _mode = AnnotationMode.NONE;
  List<int> _selectedBoxMarkings = [];
  bool _borderSelection = false;

  AnnotationMode get mode => _mode;
  List<int> get selectedBoxMarkings => _selectedBoxMarkings;
  bool get borderSelection => _borderSelection;

  set borderSelection(bool value) {
    _borderSelection = value;
    notifyListeners();
  }

  set selectedBoxMarkings(List<int> value) {
    _selectedBoxMarkings = value;
    notifyListeners();
  }

  set mode(AnnotationMode value) {
    _mode = value;
    notifyListeners();
  }

  toggleMode(AnnotationMode value) {
    _mode = _mode == value ? AnnotationMode.NONE : value;
    notifyListeners();
  }
}
