// lib/bloc/auth/auth_event.dart
abstract class AuthRegisterEvent {}

class RegisterRequested extends AuthRegisterEvent {
  final String employeeName, email, password, departmentID, employeeID;
  RegisterRequested(
      this.employeeName,
      this.email,
      this.password,
      this.departmentID,
      this.employeeID,
      );
}
