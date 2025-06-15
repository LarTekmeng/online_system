import 'package:bloc/bloc.dart';
import '../../../repositories/auth_repo.dart';
import 'event.dart';
import 'state.dart';

class AuthBloc extends Bloc<AuthRegisterEvent, AuthRegisterState> {
  final AuthRepository _repo;
  AuthBloc(this._repo) : super(AuthInitial()) {
    on<RegisterRequested>(_onRegister);
  }

  Future<void> _onRegister(RegisterRequested e, Emitter<AuthRegisterState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repo.registerUser(
        e.employeeName, e.email, e.password, e.departmentID as int, e.employeeID
      );
      emit(AuthAuthenticated(user));
    } catch (ex) {
      emit(AuthFailure(ex.toString()));
    }
  }
}
