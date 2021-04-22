import 'package:klint/api/utils.dart';

class MarkingsApi {
  static const String BASE_URL = "markings";
  static getUrl(String subUrl) => getCompositeUrl(BASE_URL, subUrl);
}
