import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardCarouselItem extends StatelessWidget {
  final Board post;
  const BoardCarouselItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/post/${post.eventId}'),
      child: Stack(
        children: [
          Container(
            width: 297.w,
            height: 480.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: post.media != null && post.media!.isNotEmpty
                    ? NetworkImage(post.media!)
                    : const NetworkImage(
                        'https://cafe24.poxo.com/ec01/khsdadmin/mSaNeAoTdVWKy3i/vGUYzGAb8qcB+ueHqM6QPLIb837hUhuuj0OAIeyQbF7bGCQg/_/web/product/big/202011/93ac3a43b738dcb5ab37a7e071f70323.jpg'), //쿠옹이
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: 297.w,
            height: 480.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [
                    0.25,
                    1
                  ]),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 50), // TODO: 재난 아이콘들 넣기
                Text(
                  post.content ?? '',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
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
