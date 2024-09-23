import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/board/viewmodels/board_viewmodel.dart';
import 'package:sos/features/board/views/widgets/board_carousel_item.dart';

class BoardCarouselWidget extends ConsumerStatefulWidget {
  const BoardCarouselWidget({super.key});

  @override
  ConsumerState<BoardCarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends ConsumerState<BoardCarouselWidget> {
  //final PageController _pageController = PageController(viewportFraction: 0.6);
  final PageController _pageController = PageController(viewportFraction: 0.5);
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
          _pageController.jumpToPage(_infiniteScrollOffset ~/ 2);
          setState(() {
            _isPageInitialized = true;
          });
        },
      );
    }

    if (boardItems.isEmpty) {
      return const Center(child: Text('게시글이 없어요'));
    }

    return SizedBox(
      height: 500,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _infiniteScrollOffset, // 무한스크롤
        itemBuilder: (context, index) {
          final int actualIndex = index % boardItems.length; // 실제 인덱스 계산

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              double value = 1; // 현재 아이템의 위치 계산
              if (_pageController.position.haveDimensions) {
                value = _pageController.page! - index;
                value = (1 - (value.abs() * 0.01)).clamp(0.5, 1);
                // opacity랑 사이즈 조절
              }
              return Center(
                child: Opacity(
                  opacity: value,
                  child: SizedBox(
                    height: Curves.easeOut.transform(value) * 300,
                    width: Curves.easeOut.transform(value) * 200,
                    child: BoardCarouselItem(post: boardItems[actualIndex]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
