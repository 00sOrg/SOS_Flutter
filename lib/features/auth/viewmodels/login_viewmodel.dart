import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
import 'package:sos/shared/utils/log_util.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class LoginState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    required this.isLoggedIn,
    required this.isLoading,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static LoginState initial() {
    return LoginState(
      isLoggedIn: false,
      isLoading: false,
    );
  }
}

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepository authRepository;

  LoginViewModel(this.authRepository) : super(LoginState.initial()) {
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      String? token = await authRepository.getAccessToken();
      if (token != null) {
        state = state.copyWith(isLoggedIn: true);
        debugPrint('로그인 되어있는 유저임');
      }
    } catch (e) {
      LogUtil.e('checkLoginStatus 에러: $e');
    }
  }

  Future<void> handleLogin(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);

    try {
      bool success = await authRepository.loginUser(email, password);

      if (success) {
        state = state.copyWith(isLoggedIn: true, isLoading: false);
        debugPrint('로그인 성공');
        GoRouter.of(context).go('/home');
      } else {
        state = state.copyWith(isLoading: false);
        debugPrint('로그인 실패');
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(text: '로그인에 실패했습니다'),
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      LogUtil.e('handleLogin 에러: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '로그인 중 문제가 발생했습니다'),
      );
    }
  }

  Future<void> handleLogout(BuildContext context) async {
    try {
      await authRepository.logoutUser();
      state = state.copyWith(isLoggedIn: false);
      GoRouter.of(context).go('/login');
    } catch (e) {
      LogUtil.e('handleLogout 에러: $e');
    }
  }

  void goToSignupPage(BuildContext context) {
    GoRouter.of(context).push('/signup');
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(ref.read(authRepositoryProvider)),
);
