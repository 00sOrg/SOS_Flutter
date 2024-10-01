import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/board/views/widgets/board_tag_grid.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardCarouselItem extends StatelessWidget {
  final Board post;
  const BoardCarouselItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final dummyTags = ['홍수', '지진', '대박티비', '어쩔ㅎ'];

    return GestureDetector(
      onTap: () => context.push('/post/${post.eventId}'),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: post.media != null && post.media!.isNotEmpty
                    ? NetworkImage(post.media!)
                    : const NetworkImage(
                        'https://sos-khu-backend.s3.ap-northeast-2.amazonaws.com/sos-background.png',
                      ), //쿠옹이
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: post.media != null && post.media!.isNotEmpty
                  ? const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      stops: [0.1, 1],
                    )
                  : null,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 36),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                BoardTagGrid(items: dummyTags),
                const SizedBox(height: 12),
                Text(
                  post.content ?? '',
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      height: 1.2),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
