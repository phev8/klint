import 'package:json_annotation/json_annotation.dart';
import 'package:klint/api/entities/marking_data.dart';

part 'marking_data_container.g.dart';

@JsonSerializable()
class MarkingDataContainer {
  String key;
  MarkingData value;

  MarkingDataContainer(this.key, this.value);
  factory MarkingDataContainer.fromJson(Map<String, dynamic> json) => _$MarkingDataContainerFromJson(json);
  Map<String, dynamic> toJson() => _$MarkingDataContainerToJson(this);
}
