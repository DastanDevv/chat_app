import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnauthenticatedState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLoginEvent>(_login);
    on<AuthRegisterEvent>(_register);
    on<AuthLogoutEvent>(_logout);
  }
  Future<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
    //отправка на firebase
    emit(
      AuthenticatedState(
        User(email: event.email, password: event.password),
      ),
    );
  }

  Future<void> _register(
      AuthRegisterEvent event, Emitter<AuthState> emit) async {
    //отправка на firebase
    emit(
      AuthenticatedState(
        User(email: event.email, password: event.password),
      ),
    );
  }

  Future<void> _logout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    //отправка на firebase logout request
    emit(UnauthenticatedState());
  }
}
