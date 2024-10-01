import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';

class HomeState {
  final bool isSwitchLeft;
  final bool isFavoritesOpen;
  final bool isNotificationSideSheetOpen;
  final List<Post> posts;
  final bool isSearchFocused;

  HomeState({
    this.isSwitchLeft = true,
    this.isFavoritesOpen = false,
    this.isNotificationSideSheetOpen = false,
    this.posts = const [], // 초기값은 빈 리스트
    this.isSearchFocused = false,
  });

  HomeState copyWith({
    bool? isSwitchLeft,
    bool? isFavoritesOpen,
    bool? isNotificationSideSheetOpen,
    List<Post>? posts,
    bool? isSearchFocused,
  }) {
    return HomeState(
      isSwitchLeft: isSwitchLeft ?? this.isSwitchLeft,
      isFavoritesOpen: isFavoritesOpen ?? this.isFavoritesOpen,
      isNotificationSideSheetOpen:
          isNotificationSideSheetOpen ?? this.isNotificationSideSheetOpen,
      posts: posts ?? this.posts, // posts 복사
      isSearchFocused: isSearchFocused ?? this.isSearchFocused,
    );
  }
}

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState());

  void toggleSwitch() {
    state = state.copyWith(isSwitchLeft: !state.isSwitchLeft);
    if (state.isSwitchLeft) {
      debugPrint("SWITCH LEFT");
    } else {
      debugPrint("SWITCH RIGHT");
    }
  }

  void toggleDropdown() {
    state = state.copyWith(isFavoritesOpen: !state.isFavoritesOpen);
  }

  void toggleNotificationSideSheet() {
    state = state.copyWith(
        isNotificationSideSheetOpen: !state.isNotificationSideSheetOpen);
  }

  void toggleSearchFocus(bool isFocused) {
    state = state.copyWith(isSearchFocused: isFocused);
  }

  // 현재 사용하지 않음 - map viewmodel에서 사용자 누르는면 이동하는거 처리 중
  void navigateToUser(BuildContext context, String user) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(user),
                const Text('이렇게 페이지 이동 되는거 신경쓰지 마셈'),
                const Text('걍 아무 액션이나 할당해놓은거임'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});
