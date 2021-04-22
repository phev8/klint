import 'package:json_annotation/json_annotation.dart';
import 'package:klint/api/entities/project.dart';

part 'project_container.g.dart';

@JsonSerializable()
class ProjectContainer {
  String key;
  Project value;

  ProjectContainer(this.key, this.value);
  factory ProjectContainer.fromJson(Map<String, dynamic> json) => _$ProjectContainerFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectContainerToJson(this);
}
