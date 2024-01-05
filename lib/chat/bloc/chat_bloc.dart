import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required this.db,
    required this.currentUser,
    required this.secondUser,
  }) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    // on<GetChatEvent>(_getChat);
  }

  final User currentUser;
  final User secondUser;
  final FirebaseFirestore db;
  // late final Stream<DocumentSnapshot<Map<String, dynamic>>> chatSubscription;

  Stream<DocumentSnapshot<Map<String, dynamic>>> get chatStream {
    return db.collection('chats').doc(getChatId).snapshots();
  }

  // void _getChat(GetChatEvent event, Emitter<ChatState> emit) {
  //   emit(ChatLoading());

  //   chatSubscription = db.collection('chats').doc(getChatId).snapshots();
  // }

  String get getChatId {
    final idList = <String>[currentUser.uid, secondUser.uid];
    idList.sort();
    return idList.join('-');
  }
}
