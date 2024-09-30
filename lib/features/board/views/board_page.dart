import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:sos/features/board/viewmodels/board_viewmodel.dart';
import 'package:sos/features/board/views/widgets/board_carousel_widget.dart';
import 'package:sos/features/board/views/widgets/board_search_bar.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:lottie/lottie.dart';

class BoardPage extends ConsumerStatefulWidget {
  const BoardPage({super.key});

  @override
  ConsumerState<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends ConsumerState<BoardPage> {
  // final ScrollController _scrollController = ScrollController();
  bool _showDesc = true;
  Timer? _hideDescTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(boardViewModelProvider.notifier).refreshBoard();
    });

    _hideDescTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showDesc = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _hideDescTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final boardItems = ref.watch(boardViewModelProvider);
    return SafeArea(
      bottom: false,
      child: KeyboardDismisser(
        child: Scaffold(
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: BoardSearchBar(),
              ),
              const Divider(
                color: AppColors.finalGray,
                height: 1,
                thickness: 1,
              ),
              const Spacer(),
              const BoardCarouselWidget(),
              const SizedBox(height: 33),
              if (_showDesc) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/lottie/Animation_swipe_left.json',
                      width: 50,
                      height: 50,
                    ),
                    const SizedBox(width: 20),
                    Lottie.asset(
                      'assets/lottie/Animation_swipe_right.json',
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                // SvgPicture.asset(
                //   'assets/icons/side_arrow.svg',
                //   height: 22,
                // ),

                const SizedBox(
                  height: 20,
                  child: Text(
                    '좌우로 스와이프해서 사건 사고를 확인해보세요!',
                    style: TextStyle(
                      color: AppColors.textGray,
                      fontSize: 14,
                      height: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
              ] else ...[
                const SizedBox(height: 81),
              ]
            ],
          ),
        ),
      ),
    );
  }
}


              // Expanded(
              //   child: RefreshIndicator.adaptive(
              //     displacement: 20,
              //     onRefresh: () async {
              //       await ref
              //           .read(boardViewModelProvider.notifier)
              //           .refreshBoard();
              //     },
              //     child: SingleChildScrollView(
              //       physics: const AlwaysScrollableScrollPhysics(),
              //       child: ConstrainedBox(
              //         constraints: BoxConstraints(
              //           minHeight: MediaQuery.of(context).size.height - 59 - 71 - 94,
              //         ),
              //         child: boardItems.isEmpty
              //             ? const Center(
              //                 child: Text('게시글이 없어요'),
              //               )
              //             : GridView.builder(
              //                 shrinkWrap: true,
              //                 padding: EdgeInsets.zero,
              //                 controller: _scrollController,
              //                 gridDelegate:
              //                     const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisCount: 3,
              //                   crossAxisSpacing: 1,
              //                   mainAxisSpacing: 1,
              //                   childAspectRatio: 1,
              //                 ),
              //                 itemCount: boardItems.length,
              //                 itemBuilder: (context, idx) {
              //                   return BoardItem(post: boardItems[idx]);
              //                 },
              //                 physics: const PageScrollPhysics(),
              //               ),
              //       ),
              //     ),
              //   ),
              // )