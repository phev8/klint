// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marking_data_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkingDataContainer _$MarkingDataContainerFromJson(Map<String, dynamic> json) {
  return MarkingDataContainer(
    json['key'] as String,
    MarkingData.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MarkingDataContainerToJson(
        MarkingDataContainer instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value.toJson(),
    };
