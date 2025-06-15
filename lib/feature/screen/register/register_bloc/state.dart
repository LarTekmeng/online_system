import 'package:equatable/equatable.dart';
import 'package:online_doc_savimex/feature/Model/employee.dart';

abstract class AuthRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthRegisterState {}
class AuthLoading extends AuthRegisterState {}

class AuthAuthenticated extends AuthRegisterState {
  final Employee user;
  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthRegisterState {
  final String error;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
