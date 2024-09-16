import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/board/viewmodels/board_viewmodel.dart';
import 'package:sos/features/board/views/widgets/board_item.dart';
import 'package:sos/features/board/views/widgets/board_search_bar.dart';

class BoardPage extends ConsumerStatefulWidget {
  BoardPage({super.key});

  @override
  ConsumerState<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends ConsumerState<BoardPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(boardViewModelProvider.notifier).refreshBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final boardItems = ref.watch(boardViewModelProvider);

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
                  await ref.read(boardViewModelProvider.notifier).refreshBoard();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: boardItems.isEmpty
                        ? const Center(
                            child: Text('게시글이 없어요'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            controller: _scrollController,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 1,
                            ),
                            itemCount: boardItems.length,
                            itemBuilder: (context, idx) {
                              return BoardItem(post: boardItems[idx]);
                            },
                            physics: const PageScrollPhysics(),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
