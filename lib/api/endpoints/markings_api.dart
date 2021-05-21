import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:klint/api/entities/marking_data.dart';
import 'package:klint/api/utils.dart';

import '../api.dart';

class MarkingsApi {
  static const String BASE_URL = "markings";
  static getUrl(String subUrl) => getCompositeUrl(BASE_URL, subUrl);

  static Future<Response> getAllMarkingDataPerProjectAndCollection(String projectKey, String collectionKey) {
    return Api.client.get(getUrl("$projectKey/$collectionKey"));
  }

  static Future<Response> getMarkingData(String projectKey, String collectionKey, String mediaKey) {
    return Api.client.get(getUrl("$projectKey/$collectionKey/$mediaKey"));
  }

  static Future<Response> putMarkingData(
      String projectKey, String collectionKey, String mediaKey, MarkingData markingData) {
    return Api.client.put(getUrl("$projectKey/$collectionKey/$mediaKey"), data: jsonEncode(markingData));
  }

  static Future<Response> deleteMarkingData(String projectKey, String collectionKey, String mediaKey) {
    return Api.client.delete(getUrl("$projectKey/$collectionKey/$mediaKey"));
  }
}
