import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeState {
  final bool isSwitchLeft;
  final bool isFavoritesOpen;
  final bool isNotificationSideSheetOpen;

  HomeState({
    this.isSwitchLeft = false,
    this.isFavoritesOpen = false,
    this.isNotificationSideSheetOpen = false, // 초기값 설정
  });

  HomeState copyWith({
    bool? isSwitchLeft,
    bool? isFavoritesOpen,
    bool? isNotificationSideSheetOpen,
  }) {
    return HomeState(
      isSwitchLeft: isSwitchLeft ?? this.isSwitchLeft,
      isFavoritesOpen: isFavoritesOpen ?? this.isFavoritesOpen,
      isNotificationSideSheetOpen:
          isNotificationSideSheetOpen ?? this.isNotificationSideSheetOpen,
    );
  }
}

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState());

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

  void navigateToNotificationPage(BuildContext context) {
    toggleNotificationSideSheet(); // 사이드 시트 열기/닫기 로직
  }

  // void navigateToNotificationPage(BuildContext context) {
  //   context.push('/notifications');
  // }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});
