import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email),
      ),
    );
  }
}
