import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final viewModel = ref.read(rescueViewModelProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(title: 'SOS'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 33, 30, 0),
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
                  // childAspectRatio: 157 / 140,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (index < friends.length) {
                    final friend = friends[index];
                    return FriendHelpBtn(
                      friend: friend,
                      onTap: () => viewModel.handleFriendHelp(
                          id: friend.favoriteMemberId,
                          name: friend.modifiedNickname),
                      // 여기서 친구의 이름을 수정된 닉네임으로 전달
                    );
                  } else if (index == friends.length && friends.length < 4) {
                    return FriendAddBtn(
                      onTap: () => viewModel.handleFriendAdd(context),
                    );
                  } else {
                    return const SizedBox();
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
              const SizedBox(height: 40),
              RescueBtn(
                onTap: () => viewModel.handleNearbyAlert(),
                text: '내 주변에 도움 요청',
                // color: AppColors.lightBlue,
                color: const Color(0xFF8FBCFF),
              ),
              const SizedBox(height: 15),
              RescueBtn(
                onTap: () => viewModel.handleEmergencyAlert(),
                text: '112 / 119에 신고하기',
                color: AppColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
