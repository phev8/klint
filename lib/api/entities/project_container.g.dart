// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectContainer _$ProjectContainerFromJson(Map<String, dynamic> json) {
  return ProjectContainer(
    json['key'] as String,
    Project.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProjectContainerToJson(ProjectContainer instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value.toJson(),
    };
