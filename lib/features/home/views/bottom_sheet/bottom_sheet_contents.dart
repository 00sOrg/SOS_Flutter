import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/nearbyEvents.dart';

class BottomSheetContent extends ConsumerWidget {
  final List<String> dummyData = List.generate(10, (index) => 'Event $index');
  final ScrollController scrollController;

  BottomSheetContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bottomSheetViewModelProvider.notifier);
    final nearbyEvents = viewModel.nearbyEvents;
    //final currentState = ref.watch(bottomSheetViewModelProvider);

    return Column(
      children: [
        // if (currentState == 0.2)
        // NearbyStatus(
        //   events: nearbyEvents,
        //   scrollController: scrollController,
        // // ),
        // else
        NearbyEvents(
          events: nearbyEvents,
          scrollController: scrollController,
        ),
      ],
    );
  }
}
