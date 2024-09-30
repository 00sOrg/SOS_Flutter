import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/shared/viewmodels/friend_viewmodel.dart';

class FavoritesDropdown extends ConsumerWidget {
  const FavoritesDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // friendViewModel의 친구 목록을 가져옴
    final friends = ref.watch(friendViewModelProvider);
    final naverMapController = ref.watch(mapControllerProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xFFDADADA).withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: friends.isEmpty
            ? [Text('친구 목록이 없습니다.')] // 친구 목록이 없을 때 표시할 메시지
            : friends.map(
                (friend) {
                  return InkWell(
                    child: Container(
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(friend.nickname), // 친구의 닉네임을 표시
                    ),
                    onTap: () {
                      if (naverMapController != null) {
                        ref
                            .read(mapViewModelProvider.notifier)
                            .onFriendMarkerTap(friend, ref,
                                naverMapController); // 친구 마커를 탭했을 때의 동작
                      } else {
                        // NaverMapController가 null일 때의 처리
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('지도 컨트롤러가 아직 초기화되지 않았습니다.')));
                      }
                    },
                  );
                },
              ).toList(),
      ),
    );
  }
}
