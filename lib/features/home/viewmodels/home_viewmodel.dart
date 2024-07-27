import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeViewModel extends StateNotifier<bool> {
  HomeViewModel() : super(false);

  void toggleDropdown() {
    state = !state;
  }

  void navigateToUser(BuildContext context, String user) {
    // 이건 임시로 버튼 액션 만들어놓은거라 그냥 Navigator.of 씀 (가라로 함)
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
    // 이건 실제로 이 페이지로 이동하는게 확정이라 GoRouter 씀 (제대로 함)
    context.push('/notifications');
  }
}

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, bool>((ref) {
  return HomeViewModel();
});
