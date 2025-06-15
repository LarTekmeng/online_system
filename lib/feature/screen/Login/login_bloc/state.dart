import 'package:equatable/equatable.dart';
import 'package:online_doc_savimex/feature/Model/employee.dart';

abstract class AuthLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthLoginState {}
class AuthLoading extends AuthLoginState {}

class AuthAuthenticated extends AuthLoginState {
  final Employee user;
  AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthLoginState {
  final String error;
  AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
