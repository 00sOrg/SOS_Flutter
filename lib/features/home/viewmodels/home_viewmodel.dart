import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';

import '../../post/viewmodels/post_list.dart';

class HomeState {
  final bool isSwitchLeft;
  final bool isFavoritesOpen;
  final bool isNotificationSideSheetOpen;
  final List<Post> posts;

  HomeState({
    this.isSwitchLeft = false,
    this.isFavoritesOpen = false,
    this.isNotificationSideSheetOpen = false,
    this.posts = const [], // 초기값은 빈 리스트
  });

  HomeState copyWith({
    bool? isSwitchLeft,
    bool? isFavoritesOpen,
    bool? isNotificationSideSheetOpen,
    List<Post>? posts,
  }) {
    return HomeState(
      isSwitchLeft: isSwitchLeft ?? this.isSwitchLeft,
      isFavoritesOpen: isFavoritesOpen ?? this.isFavoritesOpen,
      isNotificationSideSheetOpen:
          isNotificationSideSheetOpen ?? this.isNotificationSideSheetOpen,
      posts: posts ?? this.posts, // posts 복사
    );
  }
}

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState()) {
    _fetchPosts(); // 초기 데이터 로드
  }

  void _fetchPosts() {
    // 새로운 포스트 데이터를 상태에 추가합니다.
    // TODO: 실제 데이터를 불러오는 로직을 작성해야 합니다.
    state = state.copyWith(posts: dummyPosts);
  }

  void toggleSwitch() {
    state = state.copyWith(isSwitchLeft: !state.isSwitchLeft);
    if (state.isSwitchLeft) {
      log("SWITCH LEFT");
    } else {
      log("SWITCH RIGHT");
    }
  }

  void toggleDropdown() {
    state = state.copyWith(isFavoritesOpen: !state.isFavoritesOpen);
  }

  void toggleNotificationSideSheet() {
    state = state.copyWith(
        isNotificationSideSheetOpen: !state.isNotificationSideSheetOpen);
  }

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
