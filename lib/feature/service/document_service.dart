import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_doc_savimex/feature/Model/document.dart';

String _baseUrl = 'http://localhost:3000';

Future<List<Document>> fetchDocument() async {
  final uri = Uri.parse('$_baseUrl/api/documents/list');
  final resp = await http.get(uri);
  if (resp.statusCode != 200) {
    throw Exception('Failed to load Document (status ${resp.statusCode})');
  }
  final List<dynamic> body = jsonDecode(resp.body) as List<dynamic>;
  return body
      .map((e) => Document.fromJson(e as Map<String, dynamic>))
      .toList();
}
Future<Document> addDocument(int? typeId,String title, String description) async{
  final uri = Uri.parse('$_baseUrl/api/documents/create');
  final resp = await http.post(
    uri,
    headers: {'Content-Type':'application/json'},
    body: jsonEncode({'d_typeId':typeId,'d_title':title,'d_desc':description})
  );
  final data = jsonDecode(resp.body) as Map<String, dynamic>;
  if(resp.statusCode != 201){
    throw Exception(data['error'] ?? 'Fail Create Document');
  }
  final documentData = data['document'] as Map<String, dynamic>;
  return Document.fromJson(documentData);
}

