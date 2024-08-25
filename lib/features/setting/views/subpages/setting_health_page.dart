import 'package:flutter/material.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingHealthPage extends StatelessWidget {
  const SettingHealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '건강 정보 등록 및 수정',
      ),
      body: const Center(
        child: Text('Setting Health Page'),
      ),
    );
  }
}
