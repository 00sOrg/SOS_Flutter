import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authViewModelProvider = Provider((ref) => AuthViewModel());

class AuthViewModel {
  bool isLoggedIn = false;

  bool checkIfLoggedIn() {
    return isLoggedIn;
  }

  void handleLogin(BuildContext context) {
    log("LOGIN BTN PRESSED");
    GoRouter.of(context).go('/home');
  }

  void goToSignupPage(BuildContext context) {
    GoRouter.of(context).push('/signup');
  }
}
