import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/markings_api.dart';
import 'package:klint/api/entities/marking_data.dart';
import 'package:klint/api/entities/marking_data_container.dart';
import 'package:klint/ui/snack_bars.dart';

class MarkingDataState extends ChangeNotifier {
  final BuildContext context;
  final String projectKey;
  final String collectionKey;
  final String mediaKey;

  MarkingData? _markingData;

  MarkingData? get markingData => _markingData;

  MarkingDataState(this.context, this.projectKey, this.collectionKey, this.mediaKey) {
    Api.call(context, () => MarkingsApi.getMarkingData(projectKey, collectionKey, mediaKey), onSuccess: (response) {
      _markingData = MarkingDataContainer.fromJson(response.data).value;
      notifyListeners();
    });
  }

  saveToServer() {
    if (_markingData == null) {
      displayErrorSnackbar(context, "No MarkingData");
      return;
    }

    Api.call(context, () => MarkingsApi.putMarkingData(projectKey, collectionKey, mediaKey, _markingData!),
        onSuccess: (response) {
      displaySuccessSnackbar(context, "Saved Successfully");
    }, onException: (e) {
      displayErrorSnackbar(context, "Saving Failed. Exception: ${e.toString()}");
    }, onServerError: (e) {
      displayErrorSnackbar(context, "Saving Failed. Server Error: ${e.toString()}");
    });
  }

  setTag(String classID) {
    if (_markingData != null && !_markingData!.taggedClassIDs.contains(classID)) {
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
}
