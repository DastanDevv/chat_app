import 'dart:developer';

import 'package:chat_app/chat/bloc/chat_bloc.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
      {super.key, required this.secondUser, required this.currentUser});

  final User secondUser;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(secondUser.email),
      ),
      body: BlocProvider(
        create: (context) => ChatBloc(
          db: FirebaseFirestore.instance,
          currentUser: currentUser,
          secondUser: secondUser,
        )..add(GetChatEvent()),
        child: const ChatView(),
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: context.read<ChatBloc>().chatStream,
        builder: (context, snapshot) {
          log('ChatView ${snapshot.data}');
          return const Center(
            child: Text('Chat View'),
          );
        });
  }
}
