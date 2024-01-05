part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class GetChatEvent extends ChatEvent {}
