import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/utils/format_date_time.dart';
import 'package:sos/shared/utils/format_time_ago.dart';

class HeaderSection extends ConsumerWidget {
  final Post post;
  // final int? currentUserId;
  // final VoidCallback onDelete;

  const HeaderSection({
    super.key,
    required this.post,
    // this.currentUserId,
    // required this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 좌우로 분리
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title!,
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 20,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              post.roadAddress ?? '',
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              '${formatDateTime(post.createdAt!)} (${formatTimeAgo(post.createdAt!)})',
              style: const TextStyle(
                color: AppColors.textGray,
                fontSize: 11,
                fontFamily: 'Apple SD Gothic Neo',
                fontWeight: FontWeight.w300,
                height: 1.2,
              ),
            ),
          ],
        ),
        // if (currentUserId == post.memberId) // 현재 유저와 작성자가 같을 때만 옵션 아이콘을 보여줌
        //   IconButton(
        //     icon: const Icon(Icons.more_vert, color: AppColors.textGray),
        //     onPressed: () {
        //       // 옵션 아이콘 클릭 시 행동 정의
        //       _showOptions(context, post, ref);
        //     },
        //   ),
      ],
    );
  }

  // 옵션 아이콘을 눌렀을 때의 동작
  // void _showOptions(BuildContext context, Post post, WidgetRef ref) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.edit),
  //               title: const Text('수정'),
  //               onTap: () {
  //                 // 수정 동작 구현
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.delete),
  //               title: const Text('삭제'),
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //                 onDelete(); // 삭제 콜백 실행
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
