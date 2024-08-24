import 'package:flutter/material.dart';

class NotificationSideSheet extends StatefulWidget {
  const NotificationSideSheet({super.key});

  @override
  _NotificationSideSheetState createState() => _NotificationSideSheetState();
}

class _NotificationSideSheetState extends State<NotificationSideSheet> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // 처음에 사이드 시트를 숨기고, 다음 프레임에서 보여주도록 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery를 사용하여 상태바, 노치, 홈 인디케이터까지 포함하는 전체 화면 높이 설정
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(), // 바깥 영역을 누르면 닫기
          child: Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: height,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          right: _isVisible ? 0 : -MediaQuery.of(context).size.width * 0.66,
          top: 0,
          bottom: 0,
          child: Material(
            elevation: 16,
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.66, // 화면의 66%를 차지하는 사이드 시트
              height: height, // 전체 화면 높이로 설정
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '알림',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('알림 1'),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('알림 2'),
                        ),
                        // 추가 알림 항목들
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void showNotificationSideSheet(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: const Color.fromARGB(40, 0, 0, 0), // 반투명 배경
        insetPadding: EdgeInsets.zero, // insetPadding 제거
        child: NotificationSideSheet(),
      );
    },
  );
}
