import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/markings_api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/box_marking.dart';
import 'package:klint/api/entities/marking_data.dart';
import 'package:klint/api/entities/marking_data_container.dart';
import 'package:klint/ui/snack_bars.dart';

class MarkingDataState extends ChangeNotifier {
  final BuildContext context;
  final String projectKey;
  final String collectionKey;
  final String mediaKey;
  List<dynamic> _mediaKeys = [];

  MarkingData? _markingData;

  MarkingData? get markingData => _markingData;

  List<String> get mediaKeys => _mediaKeys.cast<String>();

  MarkingDataState(this.context, this.projectKey, this.collectionKey, this.mediaKey) {
    loadFromServer();
  }

  loadFromServer() {
    Api.call(context, () => MarkingsApi.getMarkingData(projectKey, collectionKey, mediaKey), onSuccess: (response) {
      _markingData = MarkingDataContainer.fromJson(response.data).value;
      notifyListeners();
    }, onServerError: (_) {
      _markingData = MarkingData(List<String>.empty(), List<BoxMarking>.empty());
    });
    Api.call(context, () => ProjectsApi.getAllProjectFiles(projectKey, collectionKey), onSuccess: (response) {
      var result = jsonDecode(response.data.toString());
      _mediaKeys = result;
    });
  }

  saveToServer() {
    if (_markingData == null) {
      displayErrorSnackbar(context, "No MarkingData");
      return;
    }

    Api.call(context, () => MarkingsApi.putMarkingData(projectKey, collectionKey, mediaKey, _markingData!), onSuccess: (response) {
      displaySuccessSnackbar(context, "Saved Successfully");
    }, onException: (e) {
      displayErrorSnackbar(context, "Saving Failed. Exception: ${e.toString()}");
    }, onServerError: (e) {
      displayErrorSnackbar(context, "Saving Failed. Server Error: ${e.toString()}");
    });
  }

  setTag(String classID) {
    if (_markingData != null && !_markingData!.taggedClassIDs.contains(classID)) {
      // Deserialization makes Lists ungrowable if they are empty. This fixes it.
      if (_markingData!.taggedClassIDs.isEmpty) {
        _markingData!.taggedClassIDs = [];
      }
      _markingData!.taggedClassIDs.add(classID);
      notifyListeners();
    }
  }

  removeTag(String classID) {
    if (_markingData != null) {
      bool success = _markingData!.taggedClassIDs.remove(classID);
      if (success) notifyListeners();
    }
  }

  set markingData(MarkingData? data) {
    _markingData = data;
    notifyListeners();
  }
}
