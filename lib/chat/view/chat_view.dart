import 'package:chat_app/chat/bloc/chat_bloc.dart';
import 'package:chat_app/components/components.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    required this.secondUser,
    required this.currentUser,
    super.key,
  });

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
        ),
        child: const ChatView(),
      ),
    );
  }
}

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MessagesView(),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 3),
          child: TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Type a message',
              suffixIcon: IconButton(
                onPressed: () async {
                  if (_textController.text.trim().isNotEmpty) {
                    context.read<ChatBloc>().add(
                          SendMessageEvent(_textController.text.trim()),
                        );
                    _textController.clear();
                  }
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
