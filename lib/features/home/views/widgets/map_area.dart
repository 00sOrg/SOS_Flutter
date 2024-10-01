import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/features/home/views/widgets/custom_marker.dart';
import 'package:sos/features/home/views/widgets/friend_marker.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/styles/global_styles.dart';
import 'package:sos/shared/viewmodels/friend_viewmodel.dart';

class MapWidget extends ConsumerWidget {
  final Location currentLocation;
  final String level;

  MapWidget({
    Key? key,
    required this.currentLocation,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchFocused = ref
        .watch(homeViewModelProvider.select((state) => state.isSearchFocused));
    final mapViewModel = ref.read(mapViewModelProvider.notifier);
    final bottomSheetViewModel =
        ref.read(bottomSheetViewModelProvider.notifier);
    final friendViewModel = ref.read(friendViewModelProvider.notifier);

    return Stack(
      children: [
        NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target:
                  NLatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 15,
              bearing: 0,
              tilt: 0,
            ),
          ),
          onMapReady: (NaverMapController controller) async {
            await _initializeMap(controller, ref, context);
          },
          onCameraIdle: () async {
            final naverMapController = ref.read(mapControllerProvider);
            if (naverMapController != null) {
              final cameraPosition =
                  await naverMapController.getCameraPosition();
              final zoomLevel = cameraPosition.zoom.round();

              await mapViewModel.fetchPostsForMap(
                level,
                cameraPosition.target.latitude,
                cameraPosition.target.longitude,
                zoomLevel,
              );
              await _updateMarkers(naverMapController, ref, context);
            }
          },
          onMapTapped: (point, latLng) {
            bottomSheetViewModel.clearTappedPost();
          },
        ),
        if (isSearchFocused)
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              debugPrint('지도 터치 감지, 키보드 dismiss');
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
      ],
    );
  }

  Future<void> _initializeMap(
    NaverMapController controller,
    WidgetRef ref,
    BuildContext context,
  ) async {
    // 지도 컨트롤러 초기화
    ref.read(mapControllerProvider.notifier).initializeController(controller);

    // NLocationTrackingMode 설정 (face, follow, noFollow, none)
    controller.setLocationTrackingMode(NLocationTrackingMode.face);
    controller
        .getLocationOverlay()
        .setCircleColor(AppColors.lightBlue.withOpacity(0.3));

    // 지도에 post 마커 및 친구 마커 추가
    await _updateMarkers(controller, ref, context);
  }

  Future<void> _updateMarkers(
    NaverMapController controller,
    WidgetRef ref,
    BuildContext context,
  ) async {
    // 지도 마커와 친구 마커를 업데이트
    await _addMarkers(controller, context, ref);
    await _addFriendMarkers(controller, context, ref);
  }

  final Set<String> currentMarkerIds = {};

  Future<void> _addMarkers(
    NaverMapController controller,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final mapViewModel = ref.watch(mapViewModelProvider);
    final posts = mapViewModel;

    final Set<String> newMarkerIds =
        posts.map((post) => post.postId.toString()).toSet();

    for (var post in posts) {
      final markerId = post.postId.toString();
      if (!currentMarkerIds.contains(markerId)) {
        final marker = await _buildMarker(post, context, ref, controller);
        controller.addOverlay(marker);
        currentMarkerIds.add(markerId);
      }
    }

    // 기존 마커 중에서 더 이상 존재하지 않는 마커 제거
    // TODO: 오류 해결 (_AssertionError ('package:flutter_naver_map/src/controller/overlay/overlay_controller_impl.dart': Failed assertion: line 49 pos 12: 'helper != null': Not Added or Already Deleted this overlay : NOverlayInfo(type: NOverlayType.marker, id: 1)))
    //_removeOldMarkers(controller, newMarkerIds);
  }

  Future<NMarker> _buildMarker(
    post,
    BuildContext context,
    WidgetRef ref,
    NaverMapController controller,
  ) async {
    if (post.mediaURL != null && post.mediaURL!.isNotEmpty) {
      final nOverlayImage = await buildImageMarkerWidget(
        post.mediaURL!,
        post.disasterType!,
        context,
      );
      return CustomImageMarker(
        id: post.postId.toString(),
        nOverlayImage: nOverlayImage,
        position: NLatLng(post.latitude!, post.longitude!),
        onTap: () {
          ref
              .read(mapViewModelProvider.notifier)
              .onMarkerTap(post, ref, controller);
        },
      );
    } else {
      return CustomMarker(
        id: post.postId.toString(),
        eventType: post.disasterType!,
        position: NLatLng(post.latitude!, post.longitude!),
        onTap: () {
          ref
              .read(mapViewModelProvider.notifier)
              .onMarkerTap(post, ref, controller);
        },
      );
    }
  }

  void _removeOldMarkers(
      NaverMapController controller, Set<String> newMarkerIds) {
    final markersToRemove = currentMarkerIds.difference(newMarkerIds);

    for (final markerId in markersToRemove) {
      if (currentMarkerIds.contains(markerId)) {
        try {
          // 마커가 존재하는 경우에만 삭제
          controller.deleteOverlay(
            NOverlayInfo(type: NOverlayType.marker, id: markerId),
          );
          currentMarkerIds.remove(markerId); // 삭제 후 트래킹 리스트에서도 제거
        } catch (e) {
          // 예외가 발생하면 에러 처리
          debugPrint("Failed to remove marker with id: $markerId, error: $e");
        }
      }
    }
  }

  Future<void> _addFriendMarkers(
    NaverMapController controller,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final friends = ref.watch(friendViewModelProvider);

    for (var friend in friends) {
      final markerId = friend.favoriteMemberId.toString();
      if (!currentMarkerIds.contains(markerId)) {
        final marker = FriendMarker(
          id: markerId,
          nickname: friend.nickname,
          position: NLatLng(friend.latitude!, friend.longitude!),
          onTap: () {
            ref
                .read(mapViewModelProvider.notifier)
                .onFriendMarkerTap(friend, ref, controller);
          },
        );
        controller.addOverlay(marker);
        currentMarkerIds.add(markerId);
      }
    }
  }
}
