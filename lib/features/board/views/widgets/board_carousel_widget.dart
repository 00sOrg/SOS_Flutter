import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sos/features/board/viewmodels/board_viewmodel.dart';
import 'package:sos/features/board/views/widgets/board_carousel_item.dart';
class BoardCarouselWidget extends ConsumerStatefulWidget {
  const BoardCarouselWidget({super.key});

  @override
  ConsumerState<BoardCarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends ConsumerState<BoardCarouselWidget> {
  //final PageController _pageController = PageController(viewportFraction: 0.6);
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final int _infiniteScrollOffset = 1000;
  bool _isPageInitialized = false;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _pageController.jumpToPage(_infiniteScrollOffset ~/ 2);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final boardItems = ref.watch(boardViewModelProvider);
    if (boardItems.isNotEmpty && !_isPageInitialized) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (_infiniteScrollOffset > 0) {
            _pageController.jumpToPage(_infiniteScrollOffset ~/ 2);
            setState(() {
              _isPageInitialized = true;
            });
          } else {
            // _infiniteScrollOffset = 0 || 음수
            debugPrint('Warning: _infiniteScrollOffset 오류, page jump 불가.');
            setState(() {
              _isPageInitialized = true;
            });
          }
        },
      );
    }

    if (boardItems.isEmpty) {
      return const SizedBox(
        height: 550,
        child: Center(child: Text('게시글이 없어요')),
      );
    }

    return SizedBox(
      height: 480.w,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _infiniteScrollOffset, // 무한스크롤
        itemBuilder: (context, index) {
          int actualIndex = 0;
          if (boardItems.isNotEmpty) {
            actualIndex = index % boardItems.length; // 실제 인덱스 계산
          } else {
            // division by zero 에러 핸들링
            debugPrint('Warning: boardItems 없음');
          }

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1; // 현재 아이템의 위치 계산
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.5)).clamp(0.5, 1);
                // 투명도 조절
              }

              return
                  // Transform.translate(
                  //   offset: Offset(value * 7.5, 0),
                  Padding(
                padding: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 33),
                child: Opacity(
                  opacity: value,
                  child: BoardCarouselItem(board: boardItems[actualIndex]),
                  // SizedBox(
                  //   // height: Curves.easeOut.transform(value) * 300,
                  //   // width: Curves.easeOut.transform(value) * 200,
                  //   height: 480.w,
                  //   width: 297,
                  //   child: BoardCarouselItem(board: boardItems[actualIndex]),
                  // ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
