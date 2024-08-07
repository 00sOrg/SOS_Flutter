import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: TextField(
          decoration: InputDecoration(
            hintText: '일단 스타일링 안함',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.5),
            suffixIcon: const Icon(Icons.search),
          ),
          onChanged: (query) {},
        ),
      ),
    );
  }
}
