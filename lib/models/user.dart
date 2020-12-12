import 'package:event_app/models/event.dart';
import 'package:event_app/models/user_event_detail.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';
@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String name;
  String imageUrl;
  String geoLocalisation;
  bool deleted;

  List<UserEventDetail> userEventDetails;
  List<Event> events;


  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
