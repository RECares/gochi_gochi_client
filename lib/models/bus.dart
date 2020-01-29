import 'package:json_annotation/json_annotation.dart';

import 'package:gochi_gochi_client/models/api_model.dart';

part 'bus.g.dart';

@JsonSerializable()
class Bus implements ApiModel {
  int id;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  Bus({this.id, this.createdAt, this.updatedAt});

  factory Bus.fromJson(Map<String, dynamic> json) => _$BusFromJson(json);

  Map<String, dynamic> toJson() => _$BusToJson(this);
}
