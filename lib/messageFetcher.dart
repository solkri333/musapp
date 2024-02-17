import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key});

  static Map<String, List> primarymails = {};
  static Map<String, List> importantmails = {};
  static Map<String, List> starredmails = {};
  static Map<String, List> spammails = {};

  Future<Map<String, List>> getImportant(
      {String url = 'http://127.0.0.1:5000/important'}) async {
    if (importantmails.isNotEmpty) {
      return importantmails;
    }
    final response = await http.get(Uri.parse(url));
    final decoded = json.decode(response.body);
    importantmails['Subject'] = decoded['Subject'];
    importantmails['Sender'] = decoded['Sender'];
    importantmails['Payload'] = decoded['msgId'];
    return importantmails;
  }

  Future<Map<String, List>> getPrimary(
      {String url = 'http://127.0.0.1:5000/'}) async {
    if (primarymails.isNotEmpty) {
      return primarymails;
    }
    getImportant();
    getSpam();
    getStarred();
    final response = await http.get(Uri.parse(url));
    final decoded = json.decode(response.body);
    primarymails['Subject'] = decoded['Subject'];
    primarymails['Sender'] = decoded['Sender'];
    primarymails['Payload'] = decoded['Payload'];
    return primarymails;
  }

  Future<Map<String, List>> getStarred(
      {String url = 'http://127.0.0.1:5000/starred'}) async {
    if (starredmails.isNotEmpty) {
      return starredmails;
    }
    final response = await http.get(Uri.parse(url));
    final decoded = json.decode(response.body);
    starredmails['Subject'] = decoded['Subject'];
    starredmails['Sender'] = decoded['Sender'];
    starredmails['Payload'] = decoded['Payload'];
    return starredmails;
  }

  Future<Map<String, List>> getSpam(
      {String url = 'http://127.0.0.1:5000/spam'}) async {
    if (spammails.isNotEmpty) {
      return spammails;
    }
    final response = await http.get(Uri.parse(url));
    final decoded = json.decode(response.body);
    spammails['Subject'] = decoded['Subject'];
    spammails['Sender'] = decoded['Sender'];
    spammails['Payload'] = decoded['Payload'];
    return spammails;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
