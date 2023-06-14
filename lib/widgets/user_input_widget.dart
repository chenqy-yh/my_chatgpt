import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_chatgpt/states/chat_ui_state.dart';

import '../models/injection.dart';
import '../models/message.dart';
import '../states/message_state.dart';
import '../states/user_touch_screen.dart';

class UserInputWidget extends HookConsumerWidget {
  const UserInputWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatUiState = ref.watch(chatUiProvider);
    final controller = TextEditingController();

    return TextField(
      enabled: !chatUiState.isRequestLoading,
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type a message',
        suffixIcon: IconButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                _sendMessage(
                    content: controller.text,
                    context: context,
                    ref: ref,
                    controller: controller);
              }
            },
            icon: const Icon(
              Icons.send,
            )),
      ),
    );
  }

  //发送消息
  _sendMessage({
    required BuildContext context,
    required WidgetRef ref,
    required String content,
    required TextEditingController controller,
  }) {
    String id = uuid.v4();
    final message = Message(
      id: id,
      content: content,
      isUser: true,
      timestamp: DateTime.now(),
    );
    ref.read(messageProvider.notifier).addMessage(message);
    controller.clear();
    _requestChatGPT(context: context, ref: ref, content: content);
  }

  //请求Gpt
  _requestChatGPT(
      {required BuildContext context,
      required WidgetRef ref,
      required String content}) async {
    ref.read(chatUiProvider.notifier).setIsRequestLoading(
          isRequestLoading: true,
        );
    //用户触摸屏幕 设置为false
    ref
        .read(userTouchScreenProvider.notifier)
        .setIsUserTouchScreen(isUserTouchScreen: false);
    try {
      final id = uuid.v4();
      await chatgpt.streamChat(
        content: content,
        onSuccess: (content) {
          final message = Message(
              id: id,
              content: content,
              isUser: false,
              timestamp: DateTime.now());
          ref
              .read(messageProvider.notifier)
              .upsertMessage(partialMessage: message);
        },
      );
    } catch (e) {
      logger.e('requestChatGPT error: $e', e);
    } finally {
      ref
          .read(chatUiProvider.notifier)
          .setIsRequestLoading(isRequestLoading: false);
    }
  }
}
