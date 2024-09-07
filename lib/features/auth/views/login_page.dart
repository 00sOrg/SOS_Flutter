import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:sos/features/auth/views/widgets/login_button.dart';
import 'package:sos/features/auth/views/widgets/login_text_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.read(authViewModelProvider);

    final TextEditingController emailTEC = TextEditingController();
    final TextEditingController passwordTEC = TextEditingController();

    return Scaffold(
      body: KeyboardDismisser(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 71.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO: svg 파일 확인 필요ㄴ
              // SvgPicture.asset(
              //   'assets/icons/logo_lean.svg',
              //   width: 96,
              //   height: 45,
              // ),
              Image.asset(
                'assets/icons/logo_lean.png',
                width: 96.w,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoginButton(
                    text: '로그인',
                    onTap: () => authViewModel.handleLogin(context),
                  ),
                  LoginButton(
                    text: '회원가입',
                    onTap: () => authViewModel.goToSignupPage(context),
                  )
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
