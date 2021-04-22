// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) {
  return Project(
    json['title'] as String,
    _$enumDecode(_$ProjectMediaTypeEnumMap, json['mediaType']),
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
      'mediaType': _$ProjectMediaTypeEnumMap[instance.mediaType],
      'classes': instance.classes.map((e) => e.toJson()).toList(),
      'tagMarkingOptions':
          instance.tagMarkingOptions.map((e) => e.toJson()).toList(),
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ProjectMediaTypeEnumMap = {
  ProjectMediaType.IMAGES: 'I',
  ProjectMediaType.VIDEO: 'V',
};
