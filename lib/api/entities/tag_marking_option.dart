import 'package:json_annotation/json_annotation.dart';

part 'tag_marking_option.g.dart';

@JsonSerializable()
class TagMarkingOption {
  String id;
  String title;
  String? additionalInfo;
  List<String> classIDs;
  bool isSingleChoice;

  TagMarkingOption(this.id, this.title, this.additionalInfo, this.classIDs, this.isSingleChoice);
  factory TagMarkingOption.fromJson(Map<String, dynamic> json) => _$TagMarkingOptionFromJson(json);
  Map<String, dynamic> toJson() => _$TagMarkingOptionToJson(this);
}
