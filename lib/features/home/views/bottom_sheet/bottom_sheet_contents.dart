import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/nearbyEvents.dart';
import 'package:sos/features/home/views/bottom_sheet/tapped_event.dart';

class BottomSheetContent extends ConsumerWidget {
  final ScrollController scrollController;

  const BottomSheetContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bottomSheetViewModelProvider);
    final nearbyEvents = viewModel.nearbyEvents;
    final tappedPost = viewModel.tappedPost;

    return Column(
      children: [
        // if (tappedPost != null)
        //   TappedEvent(
        //     post: tappedPost,
        //     scrollController: scrollController,
        //   ) // Display tapped event
        // else
        NearbyEvents(
          events: nearbyEvents,
          scrollController: scrollController,
        ),
      ],
    );
  }
}
