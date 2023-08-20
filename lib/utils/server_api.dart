import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> sendTextToServer(String text) async {
  final apiUrl = 'http://192.168.0.108:5000/?message=${text}';
  final response = await http.get(Uri.parse(apiUrl));
  print("debug: ********Made request to the API.********");

  if (response.statusCode == 200) {
    // Successful response, parse the JSON and return it
    return Map<String, dynamic>.from(json.decode(response.body));
  } else {
    // Handle errors here
    return null;
  }
}

Future<Map<String, dynamic>?> sendMessageToServer(
    types.TextMessage newMessage) async {
  final apiUrl = 'http://192.168.0.108:5000/?message=${newMessage.text}';
  final response = await http.get(Uri.parse(apiUrl));
  print("debug: ********Made request to the API.********");

  if (response.statusCode == 200) {
    // Successful response, parse the JSON and return it
    return Map<String, dynamic>.from(json.decode(response.body));
  } else {
    // Handle errors here
    return null;
  }
}