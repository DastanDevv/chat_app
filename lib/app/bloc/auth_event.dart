part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

// когда пользователь хочет войти через login
class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

// когда пользователь хочет зарегистрироваться
class AuthRegisterEvent extends AuthEvent {
  AuthRegisterEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

// когда пользователь хочет выйти
class AuthLogoutEvent extends AuthEvent {}
