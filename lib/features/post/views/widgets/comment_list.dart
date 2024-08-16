import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/post/views/widgets/comment_block.dart';
import 'package:sos/shared/models/comment.dart';

class CommentList extends ConsumerWidget {
  CommentList({super.key});
  final List<Comment> dummyComments = [
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! 헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요! ',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User3',
      profilePic: 'https://picsum.photos/202',
      createdAt: DateTime(2024, 3, 7, 23, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User1',
      createdAt: DateTime(2024, 8, 7, 12, 34),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
    Comment(
      userName: 'User2',
      profilePic: 'https://picsum.photos/201',
      createdAt: DateTime(2024, 8, 7, 13, 14),
      content:
          '헉.. 저 지금 지나가는데 돌아서 가야겠네요. 어쩐지 냄새가 너무 심하더라고요...ㅠㅠ 알려주셔서 감사합니다!! 다들 다른 길로 가시는 게 좋을 거 같아요!',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          '사건/사고 목록',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: ListView.separated(
        itemCount: dummyComments.length,
        itemBuilder: (context, index) {
          final comment = dummyComments[index];
          return CommentBlock(comment: comment);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Color(0xFFF3F3F3),
            thickness: 1,
            height: 1,
          );
        },
      ),
    );
  }
}