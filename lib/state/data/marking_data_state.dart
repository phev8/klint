import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/markings_api.dart';
import 'package:klint/api/entities/marking_data.dart';

class MarkingDataState extends ChangeNotifier {
  final String projectKey;
  final String collectionKey;
  final String mediaKey;

  MarkingData? _markingData;

  MarkingData? get markingData => _markingData;

  MarkingDataState(BuildContext context, this.projectKey, this.collectionKey, this.mediaKey) {
    Api.call(context, () => MarkingsApi.getMarkingData(projectKey, collectionKey, mediaKey), onSuccess: (response) {
      _markingData = MarkingData.fromJson(response.data);
      notifyListeners();
    });
  }
}
