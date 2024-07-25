import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nearhere/shared/models/category.dart';
import 'package:nearhere/shared/models/post.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final category = getCategory(
      CategoryKey.values
          .firstWhere((e) => e.toString() == 'CategoryKey.${post.category}'),
    );

    return InkWell(
      onTap: () {
        context.push('/post/${post.id}');
      },
      child: Container(
        padding: (post.image == null)
            ? const EdgeInsets.fromLTRB(16, 8, 16, 10)
            : const EdgeInsets.fromLTRB(8, 8, 8, 10),
        decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: (post.image == null)
              ? MainAxisAlignment.start
              : MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 2),
                SvgPicture.asset(
                  category.iconPath,
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    post.title,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF343434),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: (post.image == null)
                  ? Text(
                      post.content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(
                          0xFF595959,
                        ),
                      ),
                      softWrap: true,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Image.network(
                      post.image!,
                      width: double.infinity,
                      height: 172,
                      fit: BoxFit.cover,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
