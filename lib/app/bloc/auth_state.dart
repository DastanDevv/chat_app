part of 'auth_bloc.dart';

@immutable
//sealed это абстарак класс
sealed class AuthState {}

// проверка на аутентификацию то есть состояние когда пользоваиель аутентифицирован
final class AuthenticatedState extends AuthState {
  AuthenticatedState(this.user);
  final User user;
}

//состояние когда пользователь не аутентифицирован
final class UnauthenticatedState extends AuthState {}

//когда произошла ошибка
final class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}

//когда происходит загрузка
final class AuthLoading extends AuthState {}
