import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/rescue/viewmodels/rescue_viewmodel.dart';
import 'package:sos/features/rescue/views/widgets/friend_help_btn.dart';
import 'package:sos/features/rescue/views/widgets/rescue_btn.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class RescuePage extends ConsumerStatefulWidget {
  const RescuePage({super.key});

  @override
  _RescuePageState createState() => _RescuePageState();
}

class _RescuePageState extends ConsumerState<RescuePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(rescueViewModelProvider.notifier).fetchFriends());
  }

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(rescueViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'SOS'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 33),
        child: Column(
          children: [
            SizedBox(
              height: 305, // 전체 그리드 높이
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2열 그리드
                  mainAxisSpacing: 15, // 항목 사이의 세로 간격
                  crossAxisSpacing: 19, // 항목 사이의 가로 간격
                  childAspectRatio: 1, // 가로 세로 비율
                ),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  final friend = friends[index];
                  return FriendHelpBtn(
                    id: friend.id,
                    name: friend.name,
                    profilePicture: friend.profilePicture,
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            RescueBtn(
              text: '내 주변에 도움 요청',
              color: Colors.blue.shade200,
              onTap: () => ref
                  .read(rescueViewModelProvider.notifier)
                  .handleNearbyAlert(),
            ),
            const SizedBox(height: 15),
            RescueBtn(
              text: '112 / 119에 신고하기',
              color: Colors.blue.shade600,
              onTap: () => ref
                  .read(rescueViewModelProvider.notifier)
                  .handleEmergencyAlert(),
            ),
          ],
        ),
      ),
    );
  }
}
