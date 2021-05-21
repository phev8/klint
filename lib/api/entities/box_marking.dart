import 'package:json_annotation/json_annotation.dart';

part 'box_marking.g.dart';

@JsonSerializable()
class BoxMarking {
  String classID;
  List<double> first;
  List<double> second;

  BoxMarking(this.classID, this.first, this.second);
  factory BoxMarking.fromJson(Map<String, dynamic> json) => _$BoxMarkingFromJson(json);
  Map<String, dynamic> toJson() => _$BoxMarkingToJson(this);
}
