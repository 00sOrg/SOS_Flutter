import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SizedBox(
        height: 42,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
            border: AppBorders.defaultBorder,
            focusedBorder: AppBorders.defaultBorder,
            enabledBorder: AppBorders.defaultBorder,
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
            suffixIcon: const Icon(Icons.search, size: 26),
            // suffixIcon: SvgPicture.asset('assets/icons/search.svg')),
          ),
          cursorHeight: 20,
          autocorrect: false,
          onChanged: (query) {},
        ),
      ),
    );
  }
}
