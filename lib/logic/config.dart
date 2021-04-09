import 'package:global_configuration/global_configuration.dart';

class Config {
  static String get apiBaseUrl => GlobalConfiguration().getValue<String>("API_BASE_URL");

  static initialize() async {
    await GlobalConfiguration().loadFromPath("assets/cfg/config.json");
    // await GlobalConfiguration().loadFromAsset("config");
  }
}
