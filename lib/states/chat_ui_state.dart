import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatUiState{
  final bool isRequestLoading;
  ChatUiState({
    this.isRequestLoading = false,
  });
}


class ChatUiStateProvider extends StateNotifier<ChatUiState>{
  ChatUiStateProvider():super(ChatUiState());

  void setIsRequestLoading({
    required bool isRequestLoading
  }){
    state = ChatUiState(
      isRequestLoading: isRequestLoading
    );
  }
}

final chatUiProvider = StateNotifierProvider<ChatUiStateProvider,ChatUiState>((ref)=>ChatUiStateProvider());