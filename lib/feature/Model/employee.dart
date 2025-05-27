
class Employee{
  final int id;
  final String employeeName;
  final String email;

  Employee({
    required this.id,
    required this.employeeName,
    required this.email,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int,
      employeeName: json['employee_name'] as String,
      email:  json['email'] as String,
    );
  }
}
