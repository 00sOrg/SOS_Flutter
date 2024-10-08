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
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});
