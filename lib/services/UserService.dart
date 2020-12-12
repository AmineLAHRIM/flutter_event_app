import 'dart:convert';

import 'package:event_app/constant.dart';
import 'package:event_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  List<User> items = [];

  Future<List<User>> findAll() async {
    var response = await http.get(Constant.REST_URL + '/user/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      items = data.map((e) => User.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<User> findById(int id) async {
    var response = await http.get(Constant.REST_URL + '/user/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User currentUser = User.fromJson(data);
      return currentUser;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<User> add(User user) async {
    var response = await http.post(Constant.REST_URL + '/user/',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User newUser = User.fromJson(data);
      return newUser;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<User> update(int id, User user) async {
    var response = await http.put(
      Constant.REST_URL + '/user/' + id.toString(),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      User newUser = User.fromJson(data);
      return newUser;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<int> deleteById(int id) async {
    var response = await http.delete(
      Constant.REST_URL + '/user/' + id.toString(),
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
