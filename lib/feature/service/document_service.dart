
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:online_doc_savimex/feature/Model/document.dart';

String _bashUrl = 'http://localhost:3000';

Future<List<Document>> fetchDocument() async {
  final uri = Uri.parse('$_bashUrl/api/documents/list');
  final resp = await http.get(uri);
  if (resp.statusCode != 200) {
    throw Exception('Failed to load Document (status ${resp.statusCode})');
  }
  final List<dynamic> body = jsonDecode(resp.body) as List<dynamic>;
  return body
      .map((e) => Document.fromJson(e as Map<String, dynamic>))
      .toList();
}