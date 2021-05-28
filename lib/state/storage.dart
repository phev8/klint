import 'dart:convert';

import 'package:klint/api/entities/enums.dart';
import 'package:klint/api/entities/media_collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const PROJECT_KEY_KEY = "ProjectKey";
  static const MEDIA_COLLECTION_KEY = "MediaCollectionKey";
  static const MEDIA_KEY_KEY = "MediaKey";

  static late final SharedPreferences _instance;

  static initialize() async {
    _instance = await SharedPreferences.getInstance();
  }

  static set projectKey(String value) {
    _instance.setString(PROJECT_KEY_KEY, value);
  }

  static set mediaCollection(MediaCollection value) {
    _instance.setString(MEDIA_COLLECTION_KEY, json.encode(value.toJson()));
  }

  static set mediaKey(String value) {
    _instance.setString(MEDIA_KEY_KEY, value);
  }

  static String get projectKey => _instance.getString(PROJECT_KEY_KEY) ?? "0";
  static MediaCollection get mediaCollection {
    String? string = _instance.getString(MEDIA_COLLECTION_KEY);
    if (string != null) {
      return MediaCollection.fromJson(json.decode(string));
    } else {
      return MediaCollection("image_collection_dummy", ProjectMediaType.IMAGES, "Image Collection");
    }
  }

  static String get mediaKey => _instance.getString(MEDIA_KEY_KEY) ?? "test.jpg";
}
