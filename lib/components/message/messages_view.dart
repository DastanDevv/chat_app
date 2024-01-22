import 'dart:developer';

import 'package:chat_app/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/message/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message_model.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: context.read<ChatBloc>().chatStream,
      builder: (context, snapshot) {
        log('${snapshot.data}');
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return const Center(child: Text('No Messages'));
          } else {
            final data = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
            final messages = convertToMessages(data.docs) ?? [];
            if (messages.isEmpty) {
              return const Center(child: Text('No Messages'));
            } else {
              return Expanded(
                child: MessageSuccessWidgetState(messages),
              );
            }
          }
        }
        return const Center(child: Text('Chat View'));
      },
    );
  }

  List<Message>? convertToMessages(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    return data.map((e) => Message.fromJson(e.data())).toList();
  }
}

class MessageSuccessWidgetState extends StatelessWidget {
  const MessageSuccessWidgetState(this.messages, {super.key});

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView(
      reverse: true,
      children: messages.reversed.map((e) => MessageWidget(e)).toList(),
    );
  }
}
