import 'dart:convert';
import 'dart:io';

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

  static Future<Response> uploadFileIntoProject(String projectKey, String collectionKey, File file) async {
    FormData formData = FormData.fromMap({"file": await MultipartFile.fromFile(file.path)});
    return Api.client.post(getUrl("$projectKey/$collectionKey/files"), data: formData);
  }

  static Future<Response> getAllProjectFiles(String projectKey, String collectionKey) {
    return Api.client.get(getUrl("$projectKey/$collectionKey/files"));
  }

  static Future<Response> getProjectFile(String projectKey, String collectionKey, String fileName) {
    return Api.client.get(getUrl("$projectKey/$collectionKey/files/$fileName"));
  }

  static Future<Response> deleteProjectFile(String projectKey, String collectionKey, String fileName) {
    return Api.client.delete(getUrl("$projectKey/$collectionKey/files/$fileName"));
  }
}
