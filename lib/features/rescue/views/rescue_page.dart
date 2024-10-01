import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/rescue/viewmodels/rescue_viewmodel.dart';
import 'package:sos/features/rescue/views/widgets/friend_add_btn.dart';
import 'package:sos/features/rescue/views/widgets/friend_help_btn.dart';
import 'package:sos/features/rescue/views/widgets/rescue_btn.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/friend_viewmodel.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class RescuePage extends ConsumerStatefulWidget {
  const RescuePage({super.key});

  @override
  ConsumerState<RescuePage> createState() => _RescuePageState();
}

class _RescuePageState extends ConsumerState<RescuePage> {
  @override
  void initState() {
    super.initState();
    // 페이지가 열릴 때 친구 목록을 다시 가져옴
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(friendViewModelProvider.notifier).fetchFriendList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final friends = ref.watch(friendViewModelProvider);
    final viewModel = ref.read(rescueViewModelProvider.notifier);
    const radius = 24.0;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SOS',
        hasLeading: false,
      ),
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
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  if (index < friends.length) {
                    debugPrint(friends[index].modifiedNickname);
                    final friend = friends[index];
                    return FriendHelpBtn(
                      radius: radius,
                      friend: friend,
                      onTap: () => viewModel.handleFriendHelp(
                        id: friend.favoriteMemberId,
                        name: friend.modifiedNickname,
                      ),
                    );
                  } else if (index == friends.length && friends.length < 4) {
                    return FriendAddBtn(
                      radius: radius,
                      onTap: () => viewModel.handleFriendAdd(context),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              const SizedBox(height: 16),
              const Text(
                '* 즐겨찾는 지인은 설정에서 편집 가능합니다.',
                style: TextStyle(
                  color: AppColors.textGray,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 18),
              RescueBtn(
                radius: 12,
                onTap: () => viewModel.handleNearbyAlert(context),
                text: '내 주변에 도움 요청',
                color: const Color(0xFF8FBCFF),
              ),
              const SizedBox(height: 15.3),
              RescueBtn(
                radius: 12,
                onTap: () => viewModel.handleEmergencyAlert(),
                text: '112 / 119에 신고하기',
                color: AppColors.blue,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
