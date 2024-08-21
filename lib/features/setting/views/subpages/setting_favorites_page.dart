import 'package:flutter/material.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingFavoritesPage extends StatelessWidget {
  const SettingFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '즐겨찾는 지인 관리',
      ),
      body: const Center(
        child: Text('Setting Fav Page'),
      ),
    );
  }
}
