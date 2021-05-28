import 'package:json_annotation/json_annotation.dart';
import 'package:klint/api/entities/media_collection.dart';
import 'package:klint/api/entities/tag_marking_option.dart';

import 'enums.dart';
import 'marking_class.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  String title;
  List<MediaCollection> mediaCollections;
  List<MarkingClass> classes;
  List<TagMarkingOption> tagMarkingOptions;

  Project(this.title, this.mediaCollections, this.classes, this.tagMarkingOptions);
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
