import 'package:chat_app/chat/bloc/chat_bloc.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(this.message, {super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).colorScheme;
    final isMyMessage =
        message.isMyMessage(context.read<ChatBloc>().currentUser.uid);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        !isMyMessage ? 10 : width / 5,
        7,
        isMyMessage ? 10 : width / 5,
        7,
      ),
      child: Material(
        color: isMyMessage ? theme.primary : theme.background,
        borderOnForeground: false,
        clipBehavior: Clip.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(25),
            bottomRight: const Radius.circular(25),
            topLeft: !isMyMessage
                ? const Radius.circular(0)
                : const Radius.circular(25),
            topRight: isMyMessage
                ? const Radius.circular(0)
                : const Radius.circular(25),
          ),
        ),
        elevation: 8.0,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isMyMessage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.primary,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                message.text,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: isMyMessage ? Colors.white : null,
                ),
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd-MM-yy  hh:mm')
                        .format(DateTime.parse(message.time)),
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      color: isMyMessage ? Colors.white : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
