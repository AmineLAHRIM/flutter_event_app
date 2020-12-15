import 'dart:convert';

import 'package:event_app/constant.dart';
import 'package:event_app/models/event.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class EventService extends ChangeNotifier {
  List<Event> items = [];

  Future<List<Event>> findAll() async {
    var response = await http.get(Constant.REST_URL + '/event/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      items = data.map((e) => Event.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<Event> firstNear() async {
    if (items.isEmpty) {
      await findAll();
    }
    Event latestEventNear = items.firstWhere((element) => element.near == true);
    return latestEventNear;

  }

  Future<Event> findById(int id) async {
    print('id==findById'+id.toString());

    var response = await http.get(Constant.REST_URL + '/event/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event currentEvent = Event.fromJson(data);
      print('id==findById currentEvent');
      return currentEvent;
    } else {
      print('id==findById error');
      throw Exception('No Data Found');
    }
  }

  Future<Event> add(Event event) async {
    var response = await http.post(Constant.REST_URL + '/event/', headers: {'Content-Type': 'application/json'}, body: json.encode(event.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event newEvent = Event.fromJson(data);
      return newEvent;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<Event> update(int id, Event event) async {
    var response = await http.put(Constant.REST_URL + '/event/' + id.toString(), headers: {'Content-Type': 'application/json'}, body: json.encode(event.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Event newEvent = Event.fromJson(data);
      return newEvent;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<int> deleteById(int id) async {
    var response = await http.delete(
      Constant.REST_URL + '/event/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      int data = json.decode(response.body);
      return data;
    } else {
      throw Exception('No Data Found');
    }
  }
}
