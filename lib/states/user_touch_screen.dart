import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserTouchScreen{
  bool isUserTouchScreen = false;
  UserTouchScreen({required this.isUserTouchScreen});
}

class UserTouchScreenProvider extends StateNotifier<UserTouchScreen>{
  UserTouchScreenProvider():super(UserTouchScreen(isUserTouchScreen: false));

  void setIsUserTouchScreen({
    required bool isUserTouchScreen
  }){
    state = UserTouchScreen(
      isUserTouchScreen: isUserTouchScreen
    );
  }
}

final userTouchScreenProvider = StateNotifierProvider<UserTouchScreenProvider,UserTouchScreen>((ref)=>UserTouchScreenProvider());