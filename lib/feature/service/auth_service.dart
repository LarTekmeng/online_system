import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/document_type.dart';
import '../Model/employee.dart';

const String _baseUrl = 'http://localhost:3000';
// - Android emulator: 10.0.2.2
// - iOS Simulator or real device: use your machine IP (e.g. http://192.168.x.x:3000)

Future<Employee> registerUser(String name, String email, String password) async {
  final resp = await http.post(
    Uri.parse('$_baseUrl/api/auth/register'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'employee_name': name, 'email': email, 'password': password}),
  );
  final Map<String, dynamic> body = jsonDecode(resp.body);
  if (resp.statusCode != 200 || body['message'] != 'Registered successfully') {
    throw Exception(body['error'] ?? 'Login failed');
  }
  final employeeJson = body['employee'] as Map<String, dynamic>;
  return Employee.fromJson(employeeJson);
}

Future<Employee> loginUser(String email, String password) async {
  final resp = await http.post(
    Uri.parse('$_baseUrl/api/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  final Map<String, dynamic> body = jsonDecode(resp.body);

  if (resp.statusCode != 200 || body['message'] != 'Login successful') {
    throw Exception(body['error'] ?? 'Login failed');
  }

  // your API wraps the user under `user`
  final employeeJson = body['employee'] as Map<String, dynamic>;
  return Employee.fromJson(employeeJson);
}








