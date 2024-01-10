part of 'chat_bloc.dart';

@immutable
//sealed это абстарак класс
sealed class ChatState {}

/// Представляет собой начальное состояние чата.
class ChatInitial extends ChatState {}

/// Представляет состояние загрузки чата.
class ChatLoading extends ChatState {}

/// Представляет собой успешное состояние чата.
class ChatSuccess extends ChatState {}

/// Представляет состояние ошибки в чате.
class ChatError extends ChatState {
  /// Сообщение об ошибке, связанное с состоянием.
  ChatError(this.message);

  /// Сообщение об ошибке.
  final String message;
}
