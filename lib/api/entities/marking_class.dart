import 'package:json_annotation/json_annotation.dart';

import 'enums.dart';

part 'marking_class.g.dart';

@JsonSerializable()
class MarkingClass {
  String classID;
  String defaultTitle;
  MarkingScope scope;
  List<double> rgb;

  MarkingClass(this.classID, this.defaultTitle, this.scope, this.rgb);
  factory MarkingClass.fromJson(Map<String, dynamic> json) => _$MarkingClassFromJson(json);
  Map<String, dynamic> toJson() => _$MarkingClassToJson(this);
}
