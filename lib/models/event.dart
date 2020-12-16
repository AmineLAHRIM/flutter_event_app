import 'package:event_app/models/ticket.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/models/user_event_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  int id;
  String name;
  String address;
  DateTime date;
  String imageUrl;
  double price;
  String description;
  bool near;
  bool deleted;

  List<UserEventDetail> userEventDetails;
  List<Ticket> tickets;
  List<User> users;


  Event();

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
