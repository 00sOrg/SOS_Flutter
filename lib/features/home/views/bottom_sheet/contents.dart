import 'package:flutter/material.dart';

class BottomSheetContent extends StatelessWidget {
  final ScrollController scrollController;
  final List<String> dummyData = List.generate(10, (index) => 'Event $index');

  BottomSheetContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
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
            onTap: () => _showEventDetails(context, dummyData[index - 2]),
          );
        }
      },
    );
  }

//TODO: 이벤트 불러오기 & 누르면 이벤트 페이지로 넘어가게
  void _showEventDetails(BuildContext context, String event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Event Detail'),
          content: Text('$event 상세 내용입니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('닫기'),
            ),
          ],
        );
      },
    );
  }
}
