import 'package:flutter/material.dart';
import 'package:sos/features/setting/views/widgets/setting_favorite_block.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class SettingFavoritePage extends StatelessWidget {
  const SettingFavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '즐겨찾는 지인 관리',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 33),
          child: Column(
            children: [
              SettingFavoriteBlock(
                id: 1,
                content: '밀어봐용~',
                onSlide: () {
                  debugPrint('SLIDE ACTION 구현');
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
