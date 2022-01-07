import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_usage/model/user_data/users_data_response.dart';

final String api ="https://randomuser.me/api/?results=";
int userCount=10;

Future<List<dynamic>> fetchUsersData() async {
  final request=api+userCount.toString();
  final response = await http.get(Uri.parse(request));

  if (response.statusCode == 200) {
    final result = json.decode(response.body);
    debugPrint("result-----${result}");
    return result['results'];
  }
  else {
    throw Exception('Failed to load UsersData');
  }
}