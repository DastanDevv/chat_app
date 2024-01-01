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
final class AuthErrorState extends AuthState {
  AuthErrorState(this.message);
  final String message;
}

//когда происходит загрузка
final class AuthLoadingState extends AuthState {}
