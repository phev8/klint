import 'package:flutter/material.dart';
import 'package:klint/api/entities/media_collection.dart';
import 'package:klint/state/storage.dart';

class AppState extends ChangeNotifier {
  String _projectKey = Storage.projectKey;
  MediaCollection _mediaCollection = Storage.mediaCollection;
  String _mediaKey = Storage.mediaKey;

  String get projectKey => _projectKey;
  MediaCollection get mediaCollection => _mediaCollection;
  String get mediaKey => _mediaKey;

  set projectKey(String value) {
    _projectKey = value;
    Storage.projectKey = value;
    notifyListeners();
  }

  set mediaCollection(MediaCollection value) {
    _mediaCollection = value;
    Storage.mediaCollection = value;
    notifyListeners();
  }

  set mediaKey(String value) {
    _mediaKey = value;
    Storage.mediaKey = value;
    notifyListeners();
  }
}
