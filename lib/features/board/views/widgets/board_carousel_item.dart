import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/board/views/widgets/board_tag_grid.dart';
import 'package:sos/shared/enums/type_enum.dart';
import 'package:sos/shared/models/board.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/widgets/custom_animated_scale.dart';

class BoardCarouselItem extends StatelessWidget {
  final Board board;
  const BoardCarouselItem({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    final eventType = getPostTypeFromString(board.eventType!);
    final keywords = [eventType.koreanName, ...?board.keywords];

    return CustomAnimatedScaleDown(
      duration: 100,
      scaleValue: 0.98,
      onTap: () => context.push('/post/${board.eventId}'),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // 모서리 둥글게
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.35),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(5, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: board.media != null && board.media!.isNotEmpty
                      ? NetworkImage(board.media!)
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
                gradient: board.media != null && board.media!.isNotEmpty
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
                    board.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  BoardTagGrid(items: keywords),
                  const SizedBox(height: 12),
                  Text(
                    board.content ?? '',
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
      ),
    );
  }
}
