import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardSearchBar extends ConsumerStatefulWidget {
  const BoardSearchBar({super.key});

  @override
  ConsumerState<BoardSearchBar> createState() => _BoardSearchBarState();
}

class _BoardSearchBarState extends ConsumerState<BoardSearchBar> {
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

  @override
  void dispose() {
    searchController.dispose(); // TextEditingController의 리소스를 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 18, // 패딩 맞춤
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 둥근 모서리 설정
              borderSide: const BorderSide(
                color: AppColors.lightBlue,
                width: 2.0, // 테두리 두께 설정
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 포커스 시 둥근 모서리 설정
              borderSide: const BorderSide(
                color: AppColors.blue,
                width: 2.0, // 포커스 시 테두리 두께 설정
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 활성화 시 둥근 모서리 설정
              borderSide: const BorderSide(
                color: AppColors.lightBlue,
                width: 2.0, // 활성화 시 테두리 두께 설정
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.9), // 배경 색 설정
            suffixIcon: GestureDetector(
              onTap: () {
                // 검색 아이콘 클릭 시 검색 실행
                performSearch(searchController.text);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10), // 오른쪽 패딩 추가
                child: Image.asset(
                  'assets/icons/home/Search.png',
                  width: 28, // 아이콘 크기 조정
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32, // 아이콘의 최소 크기 및 제약 조건 설정
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
