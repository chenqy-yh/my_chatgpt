import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_chatgpt/states/user_touch_screen.dart';
import 'package:my_chatgpt/widgets/chat_message_list.dart';
import 'package:my_chatgpt/widgets/user_input_widget.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  get itemCount => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Listener(
        onPointerMove: (event) {
          //滑动距离大于100 设置为false
          if (event.delta.dy.abs() > 1) {
            ref
                .read(userTouchScreenProvider.notifier)
                .setIsUserTouchScreen(isUserTouchScreen: true);
          }
        },
        child: const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                // 聊天消息列表
                child: ChatMessageList(),
              ),
              //用户输入框
              UserInputWidget(),
            ],
          ),
        )),
      ),
    );
  }
}
