import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/auth/viewmodels/login_viewmodel.dart';
import 'package:sos/features/auth/views/widgets/login_button.dart';
import 'package:sos/features/auth/views/widgets/login_text_field.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();

  @override
  void dispose() {
    emailTEC.dispose();
    passwordTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    return KeyboardDismisser(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 71.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/new_logo.png',
                width: 213.w,
              ),
              const SizedBox(height: 60),
              LoginTextField(
                hintText: '이메일',
                controller: emailTEC,
                maxLength: 80,
              ),
              const SizedBox(height: 24),
              LoginTextField(
                hintText: '비밀번호',
                controller: passwordTEC,
                obscureText: true,
                maxLength: 100,
              ),
              const SizedBox(height: 54),
              if (loginState.isLoading) const CircularProgressIndicator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoginButton(
                    text: '로그인',
                    onTap: () => loginViewModel.handleLogin(
                      context,
                      emailTEC.text,
                      passwordTEC.text,
                    ),
                  ),
                  LoginButton(
                    text: '회원가입',
                    onTap: loginState.isLoading
                        ? () {}
                        : () => loginViewModel.goToSignupPage(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
