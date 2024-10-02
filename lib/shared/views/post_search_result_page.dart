import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/board/views/widgets/board_search_bar.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/post_preview.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/viewmodels/post_search_viewmodel.dart';
import 'package:sos/shared/widgets/custom_app_bar.dart';

class PostSearchResultPage extends ConsumerWidget {
  final String keyword;

  const PostSearchResultPage({required this.keyword, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // PostSearchViewModel에서 검색 결과 가져오기
    final futureEvents =
        ref.read(postSearchViewModelProvider.notifier).searchPosts(keyword);

    return Scaffold(
      appBar: CustomAppBar(
        title: '"$keyword" 검색 결과',
        onTapLeading: () => GoRouter.of(context).pop(),
      ),
      body: Column(
        children: [
          // BoardSearchBar 추가
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), // 패딩을 추가
            child: BoardSearchBar(), // 상단에 검색 바 배치
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: futureEvents, // 검색 결과를 Future로 처리
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(), // 로딩 인디케이터 표시
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'), // 에러 발생 시 표시
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('검색 결과가 없습니다.'),
                  );
                } else {
                  final events = snapshot.data!;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10), // 양쪽에 10만큼 패딩 추가
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event =
                            events[index]; // index에 맞게 events의 항목을 가져옴

                        return PostPreview(
                          event: event,
                          onTap: () async {
                            ref
                                .read(bottomSheetViewModelProvider.notifier)
                                .navigateToPost(context, event.postId);
                          },
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
