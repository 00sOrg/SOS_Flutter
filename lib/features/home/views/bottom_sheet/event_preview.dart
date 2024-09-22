import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class EventPreview extends StatelessWidget {
  final Post event;
  final VoidCallback onTap;

  const EventPreview({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double paddingRatio = 0.0763; // 30px을 393px로 나눈 비율
    double paddingValue = MediaQuery.of(context).size.width * paddingRatio;

    final timeText = formatTimeAgo(event.createdAt!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: EdgeInsets.symmetric(horizontal: paddingValue),
        child: Center(
          // Center 위젯을 사용하여 내부 내용을 중간에 위치하게 설정
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Row 내부 요소들을 중앙에 정렬
            children: [
              if (event.mediaURL != null) ...[
                Container(
                  width: 85,
                  height: 85,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(event.mediaURL!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Column의 내용이 중앙에 오도록 설정
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.title!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // 한 줄 이상 넘어가면 ...으로 표시
                          ),
                        ),
                        const SizedBox(width: 8), // 제목과 시간 사이의 간격 조정
                        Text(
                          timeText,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      event.content ?? '',
                      maxLines: event.mediaURL != null
                          ? 2
                          : 3, // 미디어가 있는 경우 더 적은 줄을 사용
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
