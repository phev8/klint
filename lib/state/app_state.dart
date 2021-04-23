import 'package:flutter/material.dart';
import 'package:klint/state/storage.dart';

class AppState extends ChangeNotifier {
  String _projectKey = Storage.projectKey;
  String _mediaKey = Storage.mediaKey;

  String get projectKey => _projectKey;
  String get mediaKey => _mediaKey;

  set projectKey(String value) {
    _projectKey = value;
    Storage.projectKey = value;
    notifyListeners();
  }

  set mediaKey(String value) {
    _mediaKey = value;
    Storage.mediaKey = value;
    notifyListeners();
  }
}
