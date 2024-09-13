import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/auth/repositories/auth_repository.dart';
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

  LoginViewModel(this.authRepository) : super(LoginState.initial());

  Future<void> handleLogin(
      BuildContext context, String email, String password) async {

    state = state.copyWith(isLoading: true);

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
  }

  void goToSignupPage(BuildContext context) {
    GoRouter.of(context).push('/signup');
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel((AuthRepository())),
);
