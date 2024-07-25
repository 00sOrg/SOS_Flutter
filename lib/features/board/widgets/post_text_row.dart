import 'package:flutter/material.dart';
import 'package:nearhere/shared/models/category.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostTextRow extends StatelessWidget {
  final String text;
  final CategoryKey? categoryKey;
  // final Widget? prefixIcon;

  const PostTextRow({
    super.key,
    required this.text,
    this.categoryKey,
    // this.prefixIcon = const Icon(Icons.location_on_outlined),
  });

  @override
  Widget build(BuildContext context) {
    Widget prefixIcon;

    if (categoryKey != null) {
      final category = getCategory(categoryKey!);
      prefixIcon = SvgPicture.asset(
        category.iconPathColored,
        width: 20,
        height: 20,
      );
    } else {
      prefixIcon = const Icon(Icons.location_on_outlined);
    }

    return Row(
      children: [
        SizedBox(
          width: 34,
          height: 34,
          child: prefixIcon,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
