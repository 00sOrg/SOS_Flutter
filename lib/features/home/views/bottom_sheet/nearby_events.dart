import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/post_preview.dart';
import 'package:sos/features/home/views/bottom_sheet/user_location_btn.dart';
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
    final locationState = ref.watch(locationViewModelProvider);
    final naverMapController = ref.watch(mapControllerProvider);

    return locationState.when(
      data: (location) {
        final currentLocation = location.adminAddress;
        return Flexible(
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(bottom: 20),
            shrinkWrap: true,
            itemCount: events.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Stack(
                  children: [
                    Container(
                      color: AppColors.white,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$currentLocation',
                            style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                            height: 27,
                            constraints: BoxConstraints(
                              minWidth: 155,
                            ),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 1, color: AppColors.blue),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: IntrinsicWidth(
                              child: Center(
                                child: Text(
                                  '오늘의 사건/사고:${events.length}건', // Your text here
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 15,
                      child: UserLocationBtn(
                        onTap: () => ref
                            .read(mapViewModelProvider.notifier)
                            .onLocationBtnTap(naverMapController!),
                        icon: Align(
                          alignment: Alignment(1, 1),
                          child: Image.asset(
                            'assets/icons/home/Location1.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                final event = events[index - 1]; // HandleBar 이후의 항목은 -1
                return PostPreview(
                  event: event,
                  onTap: () => {
                    ref
                        .read(bottomSheetViewModelProvider.notifier)
                        .navigateToPost(context, event.postId),
                    ref
                        .read(mapViewModelProvider.notifier)
                        .updateCameraToCenter(
                          event.latitude!,
                          event.longitude!,
                          naverMapController!,
                        ),
                  },
                );
              }
            },
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('위치 정보를 불러오지 못했습니다: $error'),
    );
  }
}
