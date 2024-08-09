import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/utils/format_date_time.dart';

class PostPreviewBlock extends StatelessWidget {
  final Post post;

  const PostPreviewBlock({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: post.profilePic != null
                    ? Image.network(
                        post.profilePic!,
                        width: 32,
                      )
                    : SvgPicture.asset(
                        'assets/icons/cute_icon_colored.svg',
                        width: 32,
                      ),
              ),
              const SizedBox(width: 9),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.userName,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formatDateTime(post.createdAt),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 4),
          Text(
            post.content,
            style: const TextStyle(
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
