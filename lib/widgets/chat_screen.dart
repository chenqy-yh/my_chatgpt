import 'package:flutter/material.dart';
import 'package:my_chatgpt/models/message.dart';

class ChatScreen extends StatelessWidget {
  final List<Message> messages = [
    Message(content: 'Hello', isUser: true, timestamp: DateTime.now()),
    Message(content: 'How are you?', isUser: false, timestamp: DateTime.now()),
    Message(content: 'I am fine', isUser: true, timestamp: DateTime.now()),
    Message(
        content: 'How about you?', isUser: false, timestamp: DateTime.now()),
  ];

  final _textController = TextEditingController();

  ChatScreen({super.key});

  get itemCount => null;

  _sendMessage(String content) {
    final message =
        Message(content: content, isUser: true, timestamp: DateTime.now());
    messages.add(message);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: messages.length, //message num
                itemBuilder: (context, index) {
                  return MessageItem(
                    message: messages[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 16,
                  );
                },
              ),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                suffixIcon: IconButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        _sendMessage(_textController.text);
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: Text(message.isUser ? 'A' : 'GPT'),
        ),
        const SizedBox(width: 8),
        Text(message.content),
      ],
    );
  }
}
