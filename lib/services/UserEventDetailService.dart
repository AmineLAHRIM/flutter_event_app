import 'dart:convert';

import 'package:event_app/constant.dart';
import 'package:event_app/models/event.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/models/user_event_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserEventDetailService extends ChangeNotifier {
  List<UserEventDetail> items = [];

  Future<List<UserEventDetail>> findAll() async {
    var response = await http.get(Constant.REST_URL + '/userEventDetail/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      items = data.map((e) => UserEventDetail.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<List<User>> findAllByEvent_Id(int eventId) async {
    var response = await http.get(
        Constant.REST_URL + '/userEventDetail/eventId/' + eventId.toString());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<User> users =
          data.map((e) => UserEventDetail.fromJson(e).user).toList();
      return users;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<List<Event>> findAllByUser_Id(int userId) async {
    var response = await http.get(
        Constant.REST_URL + '/userEventDetail/userId/' + userId.toString());

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Event> events =
          data.map((e) => UserEventDetail.fromJson(e).event).toList();
      return events;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<UserEventDetail> findById(int id) async {
    var response =
        await http.get(Constant.REST_URL + '/userEventDetail/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail currentUserEventDetail = UserEventDetail.fromJson(data);
      return currentUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<UserEventDetail> add(UserEventDetail userEventDetail) async {
    var response = await http.post(Constant.REST_URL + '/userEventDetail/',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userEventDetail.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail newUserEventDetail = UserEventDetail.fromJson(data);
      return newUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<UserEventDetail> update(
      int id, UserEventDetail userEventDetail) async {
    var response = await http.put(
      Constant.REST_URL + '/userEventDetail/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userEventDetail.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      UserEventDetail newUserEventDetail = UserEventDetail.fromJson(data);
      return newUserEventDetail;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<int> deleteById(int id) async {
    var response = await http.delete(
      Constant.REST_URL + '/userEventDetail/' + id.toString(),
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
