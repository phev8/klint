// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_marking_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagMarkingOption _$TagMarkingOptionFromJson(Map<String, dynamic> json) {
  return TagMarkingOption(
    json['id'] as String,
    json['title'] as String,
    json['additionalInfo'] as String?,
    (json['classIDs'] as List<dynamic>).map((e) => e as String).toList(),
    json['isSingleChoice'] as bool,
  );
}

Map<String, dynamic> _$TagMarkingOptionToJson(TagMarkingOption instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('additionalInfo', instance.additionalInfo);
  val['classIDs'] = instance.classIDs;
  val['isSingleChoice'] = instance.isSingleChoice;
  return val;
}
