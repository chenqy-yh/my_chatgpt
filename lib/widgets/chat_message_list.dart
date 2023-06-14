import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_chatgpt/states/message_state.dart';
import 'package:my_chatgpt/states/user_touch_screen.dart';

import 'message_item.dart';

class ChatMessageList extends HookConsumerWidget {
  const ChatMessageList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(messageProvider);
    final listController = useScrollController();
    final userTouchScreenState = ref.watch(userTouchScreenProvider);
    ref.listen(messageProvider, (previous, next) {
      if (userTouchScreenState.isUserTouchScreen) {
        return;
      } 
      Future.delayed(
        const Duration(milliseconds: 50),
        () {
          listController.jumpTo(
            listController.position.maxScrollExtent,
          );
        },
      );
    });

    return Stack(
      children: [
        ListView.separated(
          controller: listController,
          itemBuilder: (context, index) {
            return MessageItem(message: messages[index]);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 16,
            );
          },
          itemCount: messages.length,
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              listController.animateTo(listController.position.maxScrollExtent,
                  duration:const Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn);
            },
            child: const Icon(Icons.arrow_downward),
          ),
        )
      ],
    );
  }
}
