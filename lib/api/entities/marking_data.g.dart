// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarkingData _$MarkingDataFromJson(Map<String, dynamic> json) {
  return MarkingData(
    (json['taggedClassIDs'] as List<dynamic>).map((e) => e as String).toList(),
    (json['boxMarkings'] as List<dynamic>)
        .map((e) => BoxMarking.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MarkingDataToJson(MarkingData instance) =>
    <String, dynamic>{
      'taggedClassIDs': instance.taggedClassIDs,
      'boxMarkings': instance.boxMarkings.map((e) => e.toJson()).toList(),
    };
