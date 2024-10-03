import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/keyword_block.dart';
import 'package:sos/shared/styles/global_styles.dart';

class OverviewKeywordsandimage extends StatelessWidget {
  final String? mediaUrl;
  final String eventType;
  final List<String>? keywords;

  const OverviewKeywordsandimage({
    super.key,
    this.mediaUrl,
    required this.eventType,
    required this.keywords,
  });

  @override
  Widget build(BuildContext context) {
    return mediaUrl != null
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // 이미지 둥근 효과
                  border: Border(
                    left: BorderSide(
                      color: getTagColor(eventType), // 왼쪽 테두리 색상
                      width: 3, // 테두리 두께
                    ),
                    right: BorderSide(
                      color: getTagColor(eventType), // 오른쪽 테두리 색상
                      width: 3, // 테두리 두께
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // 이미지의 둥근 효과
                  child: Image.network(
                    mediaUrl!,
                    fit: BoxFit.cover,
                    width: 209.w,
                    height: 140.h,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTypeBlock(
                      eventType: eventType,
                      mediaUrl: mediaUrl,
                    ), // Always show event type
                    const SizedBox(height: 8),
                    ...keywords!.take(3).map((keyword) {
                      // Display up to 3 keywords
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: KeywordBlock(
                          keyword: keyword,
                          mediaUrl: mediaUrl,
                          eventType: eventType,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5, // Vertical spacing
                crossAxisSpacing: 10, // Horizontal spacing
                childAspectRatio:
                    5, // Aspect ratio based on width and height (162 / 26)
              ),
              itemCount: keywords!.length + 1, // Include eventType
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: EventTypeBlock(eventType: eventType),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: KeywordBlock(
                      keyword: keywords![index - 1],
                      eventType: eventType,
                    ),
                  );
                }
              },
            ),
          );
  }
}
