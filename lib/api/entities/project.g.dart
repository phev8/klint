// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    json['title'] as String,
    (json['mediaCollections'] as List<dynamic>)
        .map((e) => MediaCollection.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['classes'] as List<dynamic>)
        .map((e) => MarkingClass.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['tagMarkingOptions'] as List<dynamic>)
        .map((e) => TagMarkingOption.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'title': instance.title,
      'mediaCollections':
          instance.mediaCollections.map((e) => e.toJson()).toList(),
      'classes': instance.classes.map((e) => e.toJson()).toList(),
      'tagMarkingOptions':
          instance.tagMarkingOptions.map((e) => e.toJson()).toList(),
    };
