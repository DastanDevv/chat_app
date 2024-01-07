part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessageEvent extends ChatEvent {
  SendMessageEvent(this.message);
  final String message;
}
