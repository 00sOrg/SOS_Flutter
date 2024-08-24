import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:sos/features/auth/views/widgets/login_text_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.read(authViewModelProvider);

    final TextEditingController _idTEC = TextEditingController();
    final TextEditingController _passwordTEC = TextEditingController();

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginTextField(
              hintText: '아이디',
              controller: _idTEC,
            ),
            const SizedBox(height: 24),
            LoginTextField(
              hintText: '비밀번호',
              controller: _passwordTEC,
              obscureText: true,
            ),
            const SizedBox(height: 36),
            ElevatedButton(
              onPressed: () {
                authViewModel.handleLogin(context);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
