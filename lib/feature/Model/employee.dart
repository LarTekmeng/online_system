
class Employee{
  final int? id;
  final String employeeName;
  final String email;
  final int? departmentID;
  final String employeeID;

  Employee({
    this.id,
    required this.employeeName,
    required this.email,
    this.departmentID,
    required this.employeeID,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as int?,
      employeeName: (json['employee_name'] as String) ?? '',
      email:  (json['email'] as String) ?? '',
      departmentID:  json['dp_id'] as int?,
      employeeID: (json['em_id'] as String) ?? '',
    );
  }
}
