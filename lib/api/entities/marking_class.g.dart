// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marking_class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkingClass _$MarkingClassFromJson(Map<String, dynamic> json) {
  return MarkingClass(
    json['classID'] as String,
    json['defaultTitle'] as String,
    _$enumDecode(_$MarkingScopeEnumMap, json['scope']),
    (json['rgb'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
  );
}

Map<String, dynamic> _$MarkingClassToJson(MarkingClass instance) =>
    <String, dynamic>{
      'classID': instance.classID,
      'defaultTitle': instance.defaultTitle,
      'scope': _$MarkingScopeEnumMap[instance.scope],
      'rgb': instance.rgb,
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

const _$MarkingScopeEnumMap = {
  MarkingScope.TAGS: 'T',
  MarkingScope.OBJECTS: 'O',
  MarkingScope.SEGMENTS: 'S',
};
