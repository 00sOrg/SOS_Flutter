import 'package:flutter/material.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';

class ImageSection extends StatelessWidget {
  final Post post;

  const ImageSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return post.mediaURL != null && post.mediaURL!.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // 이미지 둥근 효과
              border: Border(
                left: BorderSide(
                  color: getTagColor(post.disasterType!), // 왼쪽 테두리 색상
                  width: 3, // 테두리 두께
                ),
                right: BorderSide(
                  color: getTagColor(post.disasterType!), // 오른쪽 테두리 색상
                  width: 3, // 테두리 두께
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // 이미지의 둥근 효과
              child: Image.network(
                post.mediaURL!,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
