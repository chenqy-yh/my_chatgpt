import 'package:flutter/material.dart';
import '../models/message.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Text(message.isUser ? 'A' : 'GPT'),
        ),
        const SizedBox(width: 8),
        Flexible(
            child: Container(
          margin: const EdgeInsets.only(
            top: 12,
          ),
          child: Text(message.content),
        ))
      ],
    );
  }
}