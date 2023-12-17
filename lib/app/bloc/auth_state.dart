part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthenticatedState extends AuthState {
  AuthenticatedState(this.user);
  final User user;
}

final class UnauthenticatedState extends AuthState {}

final class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}

final class AuthLoading extends AuthState {}
