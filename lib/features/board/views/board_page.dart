import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/board/models/board_model.dart';
import 'package:sos/features/board/viewmodels/board_viewmodel.dart';
import 'package:sos/features/board/views/widgets/board_item.dart';
import 'package:sos/features/board/views/widgets/board_search_bar.dart';

class BoardPage extends ConsumerWidget {
  BoardPage({super.key});

  final List<BoardModel> dummyBoardItems = List.generate(20, (index) {
    return BoardModel(
      id: index,
      title: 'Title $index',
      image: index % 5 != 0 ? 'https://picsum.photos/20${index % 10}' : null,
      content:
          '나는야 $index 번째 게시글입니다~! 어쩌구저쩌구 블라블라 로렘입섬 어쩌구 울랄라~ 우하하~~ 나는야 $index 번째 게시글입니다~! 어쩌구저쩌구 블라블라 로렘입섬 어쩌구 울랄라~ 우하하~~ 나는야 $index 번째 게시글입니다~! 어쩌구저쩌구 블라블라 로렘입섬 어쩌구 울랄라~ 우하하~~ ',
    );
  });

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BoardSearchBar(),
            Expanded(
              child: RefreshIndicator.adaptive(
                displacement: 20,
                onRefresh: () async {
                  ref.read(boardViewModelProvider).refreshBoard();
                },
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1,
                  ),
                  itemCount: dummyBoardItems.length,
                  itemBuilder: (context, idx) {
                    return BoardItem(post: dummyBoardItems[idx]);
                  },
                  physics: const PageScrollPhysics(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
