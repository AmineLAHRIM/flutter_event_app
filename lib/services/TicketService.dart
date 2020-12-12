import 'dart:convert';

import 'package:event_app/constant.dart';
import 'package:event_app/models/ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class TicketService extends ChangeNotifier {
  List<Ticket> items = [];

  Future<List<Ticket>> findAll() async {
    var response = await http.get(Constant.REST_URL + '/ticket/');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      items = data.map((e) => Ticket.fromJson(e)).toList();
      return items;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<Ticket> findById(int id) async {
    var response = await http.get(Constant.REST_URL + '/ticket/' + id.toString());

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket currentTicket = Ticket.fromJson(data);
      return currentTicket;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<Ticket> add(Ticket ticket) async {
    var response = await http.post(Constant.REST_URL + '/ticket/',
        headers: {'Content-Type': 'application/json'},
        body: json.encode(ticket.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket newTicket = Ticket.fromJson(data);
      return newTicket;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<Ticket> update(int id, Ticket ticket) async {
    var response = await http.put(Constant.REST_URL + '/ticket/' + id.toString(),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(ticket.toJson()));

    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      Ticket newTicket = Ticket.fromJson(data);
      return newTicket;
    } else {
      throw Exception('No Data Found');
    }
  }

  Future<int> deleteById(int id) async {
    var response = await http.delete(
      Constant.REST_URL + '/ticket/' + id.toString(),
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
