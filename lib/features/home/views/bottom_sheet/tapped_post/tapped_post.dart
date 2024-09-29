import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/overview_header.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/overview_keywords_image.dart';
import 'package:sos/shared/models/post.dart';

class TappedPost extends ConsumerWidget {
  final Post post;
  final ScrollController scrollController;

  const TappedPost({
    Key? key,
    required this.post,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      shrinkWrap: true,
      itemCount: 1, // Post 관련 정보를 한 번만 표시
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            OverviewHeader(
              profilePictureURL: post.userProfilePictureURL,
              title: post.title!,
              roadAddress: '수원시 영통구 매탄동',
              createdAt: post.createdAt!,
            ),
            const SizedBox(height: 6),
            OverviewKeywordsandimage(
              mediaUrl: post.mediaURL,
              eventType: post.disasterType!,
              keywords: post.keywords,
            )
          ],
        );
      },
    );
  }
}
