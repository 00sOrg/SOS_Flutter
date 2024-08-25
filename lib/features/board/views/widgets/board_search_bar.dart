import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardSearchBar extends ConsumerWidget {
  const BoardSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lineGray,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
            border: AppBorders.defaultBlueBorder,
            focusedBorder: AppBorders.defaultBlueBorder,
            enabledBorder: AppBorders.defaultBlueBorder,
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
            suffixIcon: const Icon(Icons.search, size: 26),
            // suffixIcon: SvgPicture.asset('assets/icons/search.svg')),
          ),
          cursorHeight: 20,
          autocorrect: false,
          onChanged: (query) {},
          style: const TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.1,
          ),
        ),
      ),
    );
  }
}
