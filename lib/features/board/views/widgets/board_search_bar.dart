import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardSearchBar extends ConsumerWidget {
  const BoardSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController searchController = TextEditingController();

    // 검색 실행 함수
    void performSearch(String query) {
      if (query.isNotEmpty) {
        // 검색어가 있을 때만 post-search-page로 이동
        GoRouter.of(context).push(
          '/post-search-result',
          extra: query, // 검색어 전달
        );
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 14),
            border: AppBorders.thickLightBlueBorder,
            focusedBorder: AppBorders.thickLightBlueBorder,
            enabledBorder: AppBorders.thickLightBlueBorder,
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.7),
            suffixIcon: GestureDetector(
              onTap: () {
                // 검색 아이콘 클릭 시 검색 실행
                performSearch(searchController.text);
              },
              child: const Icon(Icons.search, size: 26),
            ),
          ),
          cursorHeight: 20,
          autocorrect: false,
          onSubmitted: (query) {
            // Enter 키를 눌렀을 때 검색 실행
            performSearch(query);
          },
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
