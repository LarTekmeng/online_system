

import 'dart:convert';

import 'package:http/http.dart' as http;

const String _baseUrl = 'http://localhost:3000';

Future<Map<String, dynamic>> fetchUserById(int id) async {
  final resp = await http.get(Uri.parse('$_baseUrl/api/employees/$id'));
  if (resp.statusCode != 200) {
    throw Exception('Failed to load user');
  }
  return jsonDecode(resp.body);
}