import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../Model/department.dart';


String getLocalhost(){
  if(Platform.isAndroid){
    return 'http://10.0.2.2:3000';
  } else {
    return 'http://localhost:3000';
  }
}

class DepartmentRepository {

  final String _bashUrl = getLocalhost();
  /// Fetches all departments from GET /api/departments/department
  Future<List<Department>> fetchDepartments() async {
    final url = Uri.parse('$_bashUrl/api/departments/all');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load departments (status: ${response.statusCode})'
      );
    }

    // Parse as a List since your controller does `res.json(rows)` directly
    final List rawList = jsonDecode(response.body) as List;

    return rawList
        .map((json) => Department.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
