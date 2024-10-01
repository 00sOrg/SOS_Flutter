import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFocusNode = FocusNode();
    final TextEditingController searchController = TextEditingController();
    final mapViewModel =
        ref.read(mapViewModelProvider.notifier); // MapViewModel 가져오기

    searchFocusNode.addListener(() {
      final isFocused = searchFocusNode.hasFocus;
      ref.read(homeViewModelProvider.notifier).toggleSearchFocus(isFocused);
    });

    // 검색어로 지도 위치를 변경하는 메소드
    void searchAndMoveMap() {
      if (searchController.text.isNotEmpty) {
        final mapController = ref.read(mapControllerProvider); // 지도 컨트롤러 가져오기

        if (mapController != null) {
          mapViewModel.searchAndMoveMap(
            searchController.text,
            mapController,
            ref,
            context,
          );
        }
      }
    }

    return Expanded(
      child: SizedBox(
        height: 42,
        child: TextField(
          controller: searchController, // 검색어 저장
          autofocus: false,
          focusNode: searchFocusNode,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 둥근 모서리 설정
              borderSide: BorderSide(
                color: AppColors.lightBlue,
                width: 2.0, // 테두리 두께 설정
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 둥근 모서리 설정
              borderSide: BorderSide(
                color: AppColors.blue,
                width: 2.0, // 포커스 시 테두리 두께 설정
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // 둥근 모서리 설정
              borderSide: BorderSide(
                color: AppColors.lightBlue,
                width: 2.0, // 활성화 시 테두리 두께 설정
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF).withOpacity(0.9),
            suffixIcon: GestureDetector(
              onTap: searchAndMoveMap, // 검색 버튼 클릭 시 지도 이동
              child: Padding(
                padding: const EdgeInsets.only(right: 10), // 오른쪽에 패딩 추가
                child: Image.asset(
                  'assets/icons/home/Search.png',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: 32, // 최소 너비 설정
              minHeight: 32, // 최소 높이 설정
            ),
          ),
          cursorHeight: 20,
          autocorrect: false,
          onSubmitted: (query) {
            // Enter 키 입력 시 검색 실행
            if (query.isNotEmpty) {
              searchAndMoveMap();
            }
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
