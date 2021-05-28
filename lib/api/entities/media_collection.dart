import 'package:json_annotation/json_annotation.dart';
import 'package:klint/api/entities/enums.dart';

part 'media_collection.g.dart';

@JsonSerializable()
class MediaCollection {
  String id;
  ProjectMediaType mediaType;
  String title;

  MediaCollection(this.id, this.mediaType, this.title);
  factory MediaCollection.fromJson(Map<String, dynamic> json) => _$MediaCollectionFromJson(json);
  Map<String, dynamic> toJson() => _$MediaCollectionToJson(this);
}
