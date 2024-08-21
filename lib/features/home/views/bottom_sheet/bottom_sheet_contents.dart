import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';

class BottomSheetContent extends ConsumerWidget {
  final List<String> dummyData = List.generate(10, (index) => 'Event $index');
  final ScrollController scrollController; // Add this line

  BottomSheetContent(
      {super.key, required this.scrollController}); // Modify constructor

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const HandleBar(),
        const NearbyStatus(),
        NearbyEvents(
          events: dummyData,
          scrollController: scrollController,
        ),
      ],
    );
  }
}

class HandleBar extends StatelessWidget {
  const HandleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 5,
        width: 50,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class NearbyStatus extends StatelessWidget {
  const NearbyStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      height: 100,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      alignment: Alignment.center,
      child: const Text('현재 위치 및 사건 수'),
    );
  }
}

class NearbyEvents extends ConsumerWidget {
  final List<String> events;
  final ScrollController scrollController;

  const NearbyEvents({
    super.key,
    required this.events,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.separated(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index]),
            onTap: () => ref
                .read(bottomSheetViewModelProvider.notifier)
                .navigateToPost(context, index),
          );
        },
        separatorBuilder: (context, index) => Divider(
          thickness: 0.5,
          height: 1,
        ),
      ),
    );
  }
}
