import 'package:bloc/bloc.dart';
import '../../../repositories/auth_repo.dart';
import 'event.dart' hide AuthEvent;
import 'state.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final AuthRepository _repo;
  AuthLoginBloc(this._repo) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
  }

  Future<void> _onLogin(LoginRequested e, Emitter<AuthLoginState> emit) async {
    emit(AuthLoading());
    try {
      final employee = await _repo.loginUser(e.employeeID, e.password);
      emit(AuthAuthenticated(employee));
    } catch (ex) {
      emit(AuthFailure(ex.toString()));
    }
  }
}
