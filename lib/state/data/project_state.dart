import 'package:flutter/material.dart';
import 'package:klint/api/api.dart';
import 'package:klint/api/endpoints/projects_api.dart';
import 'package:klint/api/entities/project.dart';
import 'package:klint/api/entities/project_container.dart';

class ProjectState extends ChangeNotifier {
  final String projectKey;
  Project? _project;

  Project? get project => _project;

  ProjectState(BuildContext context, this.projectKey) {
    Api.call(context, () => ProjectsApi.getProject(projectKey), onSuccess: (response) {
      _project = ProjectContainer.fromJson(response.data).value;
      notifyListeners();
    });
  }
}
