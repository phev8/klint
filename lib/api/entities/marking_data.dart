import 'package:json_annotation/json_annotation.dart';
import 'package:klint/api/entities/box_marking.dart';

part 'marking_data.g.dart';

@JsonSerializable()
class MarkingData {
  List<String> taggedClassIDs;
  List<BoxMarking> boxMarkings;

  MarkingData(this.taggedClassIDs, this.boxMarkings);
  factory MarkingData.fromJson(Map<String, dynamic> json) => _$MarkingDataFromJson(json);
  Map<String, dynamic> toJson() => _$MarkingDataToJson(this);
}
