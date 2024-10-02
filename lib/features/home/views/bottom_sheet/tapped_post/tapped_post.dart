import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/overview_content.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/overview_header.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/overview_keywords_image.dart';
import 'package:sos/shared/models/post.dart';

class TappedPost extends ConsumerWidget {
  final Post post;
  final ScrollController scrollController;

  const TappedPost({
    super.key,
    required this.post,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        shrinkWrap: true,
        itemCount: 1, // Post 관련 정보를 한 번만 표시
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              OverviewHeader(
                  profilePictureURL: post.userProfilePictureURL,
                  title: post.title!,
                  roadAddress: post.roadAddress!,
                  createdAt: post.createdAt!,
                  postId: post.postId),
              const SizedBox(height: 10),
              OverviewKeywordsandimage(
                mediaUrl: post.mediaURL,
                eventType: post.disasterType!,
                keywords: post.keywords,
              ),
              const SizedBox(height: 25),
              OverviewContent(
                content: post.content,
              ),
            ],
          );
        },
      ),
    );
  }
}
