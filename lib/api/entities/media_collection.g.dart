// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaCollection _$MediaCollectionFromJson(Map<String, dynamic> json) {
  return MediaCollection(
    json['id'] as String,
    _$enumDecode(_$ProjectMediaTypeEnumMap, json['mediaType']),
    json['title'] as String,
  );
}

Map<String, dynamic> _$MediaCollectionToJson(MediaCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mediaType': _$ProjectMediaTypeEnumMap[instance.mediaType],
      'title': instance.title,
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
