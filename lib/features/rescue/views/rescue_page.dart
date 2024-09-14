import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/rescue/viewmodels/rescue_viewmodel.dart';
import 'package:sos/features/rescue/views/widgets/friend_add_btn.dart';
import 'package:sos/features/rescue/views/widgets/friend_help_btn.dart';
import 'package:sos/features/rescue/views/widgets/rescue_btn.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class RescuePage extends ConsumerWidget {
  const RescuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friends = ref.watch(rescueViewModelProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'SOS'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 33),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 19,
                  childAspectRatio: 157 / 145,
                ),
                itemCount: (friends.length < 4) ? friends.length + 1 : 4,
                itemBuilder: (context, index) {
                  if (index < friends.length) {
                    final friend = friends[index];
                    return FriendHelpBtn(
                      id: friend.id,
                      name: friend.name,
                      profilePicture: friend.profilePicture,
                    );
                  } else {
                    return const FriendAddBtn();
                  }
                },
              ),
              const SizedBox(height: 12),
              const Text(
                '* 즐겨찾는 지인 수정은 설정에서 편집 가능합니다.',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              // const SizedBox(height: 15),
              const SizedBox(height: 50),
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
      ),
    );
  }
}
