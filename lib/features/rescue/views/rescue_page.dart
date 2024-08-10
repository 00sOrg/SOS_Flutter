import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/rescue/viewmodels/rescue_viewmodel.dart';
import 'package:sos/features/rescue/views/widgets/friend_help_btn.dart';
import 'package:sos/features/rescue/views/widgets/rescue_btn.dart';

class RescuePage extends ConsumerWidget {
  const RescuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rescueViewModel = ref.read(rescueViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '도움 요청',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                FriendHelpBtn(image: '', text: '어쩌구'),
                SizedBox(width: 16),
                FriendHelpBtn(image: '', text: ''),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                FriendHelpBtn(image: '', text: ''),
                SizedBox(width: 16),
                FriendHelpBtn(image: '', text: '저쩌구'),
              ],
            ),
            const SizedBox(height: 52),
            RescueBtn(
              text: '내 주변에 도움 요청',
              color: Colors.blue.shade200,
              onTap: rescueViewModel.handleNearbyAlert,
            ),
            const SizedBox(height: 16),
            RescueBtn(
              text: '112 / 119에 신고하기',
              color: Colors.blue.shade600,
              onTap: rescueViewModel.handleEmergencyAlert,
            )
          ],
        ),
      ),
    );
  }
}
