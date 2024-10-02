import 'package:flutter/material.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class PostPreview extends StatelessWidget {
  final Post event;
  final VoidCallback onTap;

  const PostPreview({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final timeText = formatTimeAgo(event.createdAt!);
    final postType = getPostTypeFromString(event.disasterType!).koreanName;

    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 15,
          ), // 카드 간의 간격 추가
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              color: AppColors.lineGray.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(12), // 모서리 둥글게
            boxShadow: [
              BoxShadow(
                color: AppColors.lineGray.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(3, 6), // 그림자 위치 설정
              ),
            ],
          ),
          child: Row(
            children: [
              // 왼쪽 색상 바 추가
              Container(
                margin: const EdgeInsets.only(left: 1),
                width: 5, // 너비를 5로 설정
                height: 120, // 높이는 부모 높이에 맞게 설정
                decoration: BoxDecoration(
                  color: getTagColor(event.disasterType!), // 태그 색상에 맞게 설정
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0, vertical: 0), // 패딩 조정
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (event.mediaURL != null)
                          ? Container(
                              width: 118,
                              height: 118,
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(event.mediaURL!),
                                  fit: BoxFit.cover,
                                ),
                                border: Border(
                                  // top: BorderSide(
                                  //   color: getTagColor(
                                  //       event.disasterType!), // 위 테두리 색상
                                  //   width: 3, // 테두리 두께
                                  // ),
                                  // bottom: BorderSide(
                                  //   color: getTagColor(
                                  //       event.disasterType!), // 아래 테두리 색상
                                  //   width: 3, // 테두리 두께
                                  // ),
                                  right: BorderSide(
                                    color: getTagColor(event.disasterType!)
                                        .withOpacity(0.8), // 오른쪽 테두리 색상
                                    width: 5, // 테두리 두께
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '$postType',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      color: AppColors.textGray,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // 동그라미 추가
                                Container(
                                  width: 6, // 동그라미의 크기
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getTagColor(event
                                        .disasterType!), // 태그 색상에 맞는 동그라미 색상
                                  ),
                                ),
                                const SizedBox(width: 6), // 동그라미와 시간 텍스트 사이 간격
                                Text(
                                  timeText,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 10),
                              child: Text(
                                event.title!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                  color: AppColors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 15, bottom: 15),
                              child: Text(
                                event.content ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontSize: 14, height: 1.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Color getTagColor(String eventType) {
  switch (eventType) {
    case 'FIRE':
      return const Color(0xFFFF3535);
    case 'TYPHOON':
      return const Color(0xFFAA3DC2);
    case 'FLOOD':
      return const Color(0xFF0046AE);
    case 'WAR':
      return const Color(0xFF16AE0B);
    case 'OTHER':
      return const Color(0xFFF28C2C);
    case 'CAR_ACCIDENT':
      return const Color(0xFF00A392);
    default:
      return const Color(0xFF6398E9);
  }
}
