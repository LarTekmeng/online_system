import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

String getLocalhost(){
  if(Platform.isAndroid){
    return 'http://10.0.2.2:3000';
  }
  else {
    return 'http://localhost:3000';
  }
}
class EmployeeRepository{
  final String _baseUrl = getLocalhost();

  Future<Map<String, dynamic>> fetchEmployeeByID(String employeeId) async {
    final uri = (Uri.parse('$_baseUrl/api/employees/$employeeId'));
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Failed to load user');
    }
    return jsonDecode(resp.body) ['employee'] as Map<String, dynamic>;
  }
}