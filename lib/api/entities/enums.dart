import 'package:json_annotation/json_annotation.dart';

enum ProjectMediaType {
  @JsonValue("I")
  IMAGES,
  @JsonValue("V")
  VIDEO,
}

enum MarkingScope {
  @JsonValue("T")
  TAGS,
  @JsonValue("O")
  OBJECTS,
  @JsonValue("S")
  SEGMENTS,
}
