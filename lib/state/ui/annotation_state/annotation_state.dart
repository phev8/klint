import 'package:flutter/material.dart';
import 'package:klint/state/ui/annotation_state/annotation_mode.dart';

class AnnotationState extends ChangeNotifier {
  AnnotationMode _mode = AnnotationMode.NONE;
  Set<int> _selectedBoxMarkings = new Set();
  bool _borderSelection = false;
  bool _isAdditionalSelection = false;
  bool _isPanning = false;
  bool _isResizing = false;
  bool _isCreating = false;
  List<bool> resizingEdgesLTRB = [false, false, false, false];

  AnnotationMode get mode => _mode;
  Set<int> get selectedBoxMarkings => _selectedBoxMarkings;
  bool get borderSelection => _borderSelection;
  bool get isAdditionalSelection => _isAdditionalSelection;
  bool get isPanning => _isPanning;
  bool get isResizing => _isResizing;
  bool get isCreating => _isCreating;

  set borderSelection(bool value) {
    _borderSelection = value;
    notifyListeners();
  }

  set additionalSelection(bool value) {
    _isAdditionalSelection = value;
    notifyListeners();
  }

  set selectedBoxMarkings(Set<int> value) {
    _selectedBoxMarkings = value;
    notifyListeners();
  }

  set mode(AnnotationMode value) {
    _mode = value;
    notifyListeners();
  }

  set isPanning(bool value) {
    _isPanning = value;
    notifyListeners();
  }

  set isResizing(bool value) {
    _isResizing = value;
    notifyListeners();
  }

  set isCreating(bool value) {
    _isCreating = value;
    notifyListeners();
  }

  emptySelection() {
    _selectedBoxMarkings.clear();
    notifyListeners();
  }

  toggleMode(AnnotationMode value) {
    _mode = _mode == value ? AnnotationMode.NONE : value;
    notifyListeners();
  }

  bool hasSelections() {
    return _selectedBoxMarkings.isNotEmpty;
  }
}
