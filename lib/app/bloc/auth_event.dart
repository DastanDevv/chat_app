part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

//этот эвент отвечает за аутентификацию
class AuthInitialEvent extends AuthEvent {}

//этот эвент отвечает за вход
class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

//этот эвент отвечает за регистрацию
class AuthRegisterEvent extends AuthEvent {
  AuthRegisterEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

//этот эвент отвечает за выход
class AuthLogoutEvent extends AuthEvent {}
