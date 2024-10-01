import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/handle_bar.dart';
import 'package:sos/features/home/views/bottom_sheet/nearby_events.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_post/tapped_post.dart';

class BottomSheetContent extends ConsumerWidget {
  final ScrollController scrollController;

  const BottomSheetContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomSheetState = ref.watch(bottomSheetViewModelProvider);
    final nearbyEvents = bottomSheetState.nearbyEvents;
    final isViewingTappedPost = bottomSheetState.isViewingTappedPost;

    return Column(
      children: [
        const HandleBar(),
        if (isViewingTappedPost)
          TappedPost(
            post: bottomSheetState.tappedPost!,
            scrollController: scrollController,
          ) // Display tapped event
        else
          NearbyEvents(
            events: nearbyEvents,
            scrollController: scrollController,
          ),
      ],
    );
  }
}
