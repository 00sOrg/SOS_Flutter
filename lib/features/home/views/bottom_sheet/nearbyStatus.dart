import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/handleBar.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class NearbyStatus extends ConsumerWidget {
  final List<Post> events;
  final ScrollController scrollController;

  const NearbyStatus({
    super.key,
    required this.events,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 여기에 내 현재 위치 정보 받아와야 함
    final currentLocation = '강남구 삼성동';

    return Flexible(
      child: ListView.builder(
        controller: scrollController,
        itemCount: 2, // HandleBar와 위치 정보 표시를 위한 2개의 항목
        itemBuilder: (context, index) {
          if (index == 0) {
            // 첫 번째 항목으로 HandleBar를 추가
            return const HandleBar();
          } else {
            // 두 번째 항목으로 위치 정보와 사건 수를 표시
            return Container(
              color: Colors.grey[200],
              height: 43,
              margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF00FF0A),
                      shape: OvalBorder(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    '$currentLocation',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0.03,
                    ),
                  ),
                  const SizedBox(width: 40),
                  Text(
                    '오늘\n사건/사고:${events.length}건',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
