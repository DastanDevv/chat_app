import 'dart:developer';

import 'package:chat_app/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/components.dart';
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
                child: ListView(
                  children: messages.map((e) => MessageWidget(e)).toList(),
                ),
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
