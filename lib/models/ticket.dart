import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';
@JsonSerializable()
class Ticket{
  int id;
  bool deleted;


  Ticket();

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}