import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
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
    double paddingValue = 20;

    final timeText = formatTimeAgo(event.createdAt!);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 120,
        padding: EdgeInsets.symmetric(horizontal: paddingValue, vertical: 16),
        child: Center(
          // Center 위젯을 사용하여 내부 내용을 중간에 위치하게 설정
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (event.mediaURL != null) ...[
              //   Container(
              //     width: 85,
              //     height: 85,
              //     margin: const EdgeInsets.only(right: 13),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(4),
              //       image: DecorationImage(
              //         image: NetworkImage(event.mediaURL!),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ],
              // if (event.mediaURL != null) ...[
              //   Container(
              //     width: 85,
              //     height: 85,
              //     margin: const EdgeInsets.only(right: 13),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(4),
              //       image: DecorationImage(
              //         image: NetworkImage(event.mediaURL!),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ],
              (event.mediaURL != null)
                  ? Container(
                      width: 85,
                      height: 85,
                      margin: const EdgeInsets.only(right: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(event.mediaURL!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const SizedBox(height: 85),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            event.title!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeText,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      event.content ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, height: 1.2),
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
