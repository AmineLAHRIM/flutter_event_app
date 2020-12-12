import 'package:event_app/models/event.dart';
import 'package:event_app/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_event_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEventDetail {
  int id;
  User user;
  Event event;

  UserEventDetail();

  factory UserEventDetail.fromJson(Map<String, dynamic> json) =>
      _$UserEventDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserEventDetailToJson(this);
}
