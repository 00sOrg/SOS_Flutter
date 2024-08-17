import 'package:flutter/material.dart';
import 'package:sos/features/board/models/board_model.dart';
import 'package:sos/features/board/views/widgets/board_item.dart';

class BoardPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1,
                ),
                itemCount: dummyBoardItems.length,
                itemBuilder: (context, idx) {
                  return BoardItem(post: dummyBoardItems[idx]);
                }),
          )
        ],
      ),
    );
  }
}
