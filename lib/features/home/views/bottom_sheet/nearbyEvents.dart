import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/eventPreview.dart';
import 'package:sos/features/home/views/bottom_sheet/handleBar.dart';
import 'package:sos/shared/models/post.dart';

class NearbyEvents extends ConsumerWidget {
  final List<Post> events;
  final ScrollController scrollController;

  const NearbyEvents({
    super.key,
    required this.events,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Flexible(
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: events.length + 1, // HandleBar를 위한 하나 더 많은 count
        itemBuilder: (context, index) {
          if (index == 0) {
            // 첫 번째 항목으로 HandleBar 추가
            return const HandleBar();
          } else {
            final event = events[index - 1]; // HandleBar 이후의 항목은 -1
            return EventPreview(
              event: event,
              onTap: () => ref
                  .read(bottomSheetViewModelProvider.notifier)
                  .navigateToPost(context, event.postId),
            );
          }
        },
        separatorBuilder: (context, index) {
          // HandleBar 아래부터 Divider 추가, HandleBar 밑에는 Divider를 추가하지 않음
          return index == 0
              ? const SizedBox.shrink()
              : Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.84,
                    child: const Divider(
                      thickness: 0.5,
                      height: 1,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
