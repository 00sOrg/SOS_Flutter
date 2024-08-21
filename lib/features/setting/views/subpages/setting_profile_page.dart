import 'package:flutter/material.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingProfilePage extends StatelessWidget {
  const SettingProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '회원 정보 수정',
      ),
      body: const Center(
        child: Text('Setting Profile Page'),
      ),
    );
  }
}
