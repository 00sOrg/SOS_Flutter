import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/keyword_block.dart';

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
              Image.network(
                mediaUrl!,
                width: 209.w,
                height: 140.h,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTypeBlock(
                        eventType: eventType), // Always show event type
                    const SizedBox(height: 8),
                    ...keywords!.take(3).map((keyword) {
                      // Display up to 3 keywords
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: KeywordBlock(keyword: keyword),
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
                    child: KeywordBlock(keyword: keywords![index - 1]),
                  );
                }
              },
            ),
          );
  }
}
