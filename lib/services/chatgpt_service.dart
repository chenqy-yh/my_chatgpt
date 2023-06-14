import 'package:my_chatgpt/env.dart';
import 'package:openai_api/openai_api.dart';

class ChatGptService {
  final client = OpenaiClient(
      config: OpenaiConfig(
    apiKey: Env.apiKey,
    httpProxy: Env.httpProxy,
  ));

  Future<ChatCompletionResponse> sendChatCompletion(String content) async {
    final request = ChatCompletionRequest(
        model: Model.gpt3_5Turbo,
        messages: [ChatMessage(content: content, role: ChatMessageRole.user)]);
    ChatCompletionResponse res = await client.sendChatCompletion(request);
    return res;
  }

  Future streamChat(
      {required String content, Function(String content)? onSuccess}) async {
    final request = ChatCompletionRequest(
      model: Model.gpt3_5Turbo_0301,
      stream: true,
      messages: [
        ChatMessage(
          content: content,
          role: ChatMessageRole.user,
        )
      ],
    );

    return await client.sendChatCompletionStream(
      request,
      onSuccess: (p0) {
        final text = p0.choices.first.delta?.content;
        if (text != null) {
          onSuccess?.call(text);
        }
      },
    );
  }

}
