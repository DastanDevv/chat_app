part of 'home_cubit.dart';

/// Базовый класс для всех домашних состояний
@immutable
sealed class HomeState {}

/// Начальное состояние главной страницы
final class HomeInitial extends HomeState {}

/// Состояние, представляющее состояние загрузки главной страницы
final class HomeLoading extends HomeState {}

/// Состояние, представляющее успешную загрузку пользователей на главную страницу
final class HomeSuccess extends HomeState {
  HomeSuccess(this.users);
  final List<User> users;
}

/// Состояние, представляющее ошибку, возникшую при загрузке главной страницы
final class HomeError extends HomeState {
  HomeError(this.message);
  final String message;
}
