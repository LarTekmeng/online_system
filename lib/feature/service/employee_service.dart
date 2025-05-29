import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

String getLocalhost(){
  if(Platform.isAndroid){
    return 'http://10.0.2.2:3000';
  } else {
    return 'http://localhost:3000';
  }
}
String _baseUrl = getLocalhost();

Future<Map<String, dynamic>> fetchUserById(int id) async {
  final resp = await http.get(Uri.parse('$_baseUrl/api/employees/$id'));
  if (resp.statusCode != 200) {
    throw Exception('Failed to load user');
  }
  return jsonDecode(resp.body);
}