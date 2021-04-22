import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:klint/api/entities/project.dart';

import '../api.dart';
import '../utils.dart';

class ProjectsApi {
  static const String BASE_URL = "projects";
  static getUrl(String subUrl) => getCompositeUrl(BASE_URL, subUrl);

  static Future<Response> getAllProjects() {
    return Api.client.get(getUrl(""));
  }

  static Future<Response> getProject(String key) {
    return Api.client.get(getUrl("$key"));
  }

  static Future<Response> putProject(String key, Project project) {
    return Api.client.put(getUrl("$key"), data: jsonEncode(project));
  }

  static Future<Response> deleteProject(String key) {
    return Api.client.delete(getUrl("$key"));
  }
}
