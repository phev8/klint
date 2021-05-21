// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_marking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoxMarking _$BoxMarkingFromJson(Map<String, dynamic> json) {
  return BoxMarking(
    json['classID'] as String,
    (json['first'] as List<dynamic>).map((e) => (e as num).toDouble()).toList(),
    (json['second'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
  );
}

Map<String, dynamic> _$BoxMarkingToJson(BoxMarking instance) =>
    <String, dynamic>{
      'classID': instance.classID,
      'first': instance.first,
      'second': instance.second,
    };
