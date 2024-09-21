import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/event_preview.dart';
import 'package:sos/features/home/views/bottom_sheet/handleBar.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/location_viewmodel.dart';

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
    final locationState = ref.watch(locationProvider);

    return locationState.when(
      data: (location) {
        final currentLocation = location.adminAddress;
        // final currentLocation = location.roadAddress; // 구, 동 정보 사용
        return Flexible(
          child: ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            itemCount: events.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const HandleBar();
              } else if (index == 1) {
                return Container(
                  color: AppColors.white,
                  height: 43,
                  margin: const EdgeInsets.fromLTRB(0, 14, 0, 24),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const ShapeDecoration(
                          color: Color(0xFF00FF0A),
                          shape: OvalBorder(),
                        ),
                      ),
                      const SizedBox(width: 22),
                      Text(
                        '$currentLocation',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(width: 35),
                      Text(
                        '오늘\n사건/사고:${events.length}건',
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                final event = events[index - 2]; // HandleBar 이후의 항목은 -1
                return EventPreview(
                  event: event,
                  onTap: () => ref
                      .read(bottomSheetViewModelProvider.notifier)
                      .navigateToPost(context, event.postId),
                );
              }
            },
            separatorBuilder: (context, index) {
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
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('위치 정보를 불러오지 못했습니다: $error'),
    );
  }
}
