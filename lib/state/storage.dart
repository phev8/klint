import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static const PROJECT_KEY_KEY = "ProjectKey";
  static const MEDIA_KEY_KEY = "MediaKey";

  static late final SharedPreferences _instance;

  static initialize() async {
    _instance = await SharedPreferences.getInstance();
  }

  static set projectKey(String value) {
    _instance.setString(PROJECT_KEY_KEY, value);
  }

  static set mediaKey(String value) {
    _instance.setString(MEDIA_KEY_KEY, value);
  }

  static String get projectKey => _instance.getString(PROJECT_KEY_KEY) ?? "42";
  static String get mediaKey => _instance.getString(MEDIA_KEY_KEY) ?? "test.jpg";
}
