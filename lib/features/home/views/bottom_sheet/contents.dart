import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet.dart';

class BottomSheetContent extends ConsumerWidget {
  final ScrollController scrollController;
  final List<String> dummyData = List.generate(10, (index) => 'Event $index');

  BottomSheetContent({required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller:
          scrollController, // DraggableScrollableSheet에서 전달된 controller 사용
      itemCount: dummyData.length + 2, // 핸들바와 회색 컨테이너를 포함하여 개수 증가
      itemBuilder: (context, index) {
        if (index == 0) {
          // 핸들바 추가
          return Center(
            child: Container(
              height: 5,
              width: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        } else if (index == 1) {
          // 여기에 현재 위치, 24시간 내 사건 수 등 표시 -> 이벤트 누르면 내용 전환되게
          return Container(
            color: Colors.grey[200],
            height: 100,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            alignment: Alignment.center,
            child: const Text('현재 위치 및 사건 수'),
          );
        } else {
          // 리스트 아이템
          return ListTile(
            title: Text(dummyData[index - 2]), // 인덱스를 조정하여 데이터 표시
            onTap: () => _navigateToPost(context, ref, index - 2),
          );
        }
      },
    );
  }

  // 페이지 이동 전에 바텀시트를 닫고 페이지로 이동하는 함수
  void _navigateToPost(BuildContext context, WidgetRef ref, int postId) {
    ref.read(bottomSheetControllerProvider.notifier).closeBottomSheet();

    // 페이지 전환
    context.go('/post/$postId');
  }
}
