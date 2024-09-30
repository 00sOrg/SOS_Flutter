import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/features/home/views/widgets/custom_marker.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/styles/global_styles.dart';

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
          onMapReady: (NaverMapController controller) {
            ref
                .read(mapControllerProvider.notifier)
                .initializeController(controller);
            debugPrint('NaverMapController initialized');
            controller.setLocationTrackingMode(NLocationTrackingMode.face);
            controller
                .getLocationOverlay()
                .setCircleColor(AppColors.lightBlue.withOpacity(0.3));
            mapViewModel.fetchPostsForMap(
                level, currentLocation.latitude, currentLocation.longitude, 15);

            _addMarkers(controller, context, ref);
          },
          onCameraIdle: () async {
            final naverMapController = ref.read(mapControllerProvider);
            if (naverMapController != null) {
              final cameraPosition =
                  await naverMapController.getCameraPosition();
              final zoomLevel = cameraPosition.zoom.round();
              mapViewModel.fetchPostsForMap(
                  level,
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                  zoomLevel);
              // bottomSheetViewModel.fetchNearbyEvents(
              //     cameraPosition.target.latitude,
              //     cameraPosition.target.longitude);
              _addMarkers(naverMapController, context, ref);
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

  final Set<String> currentMarkerIds = {};

  Future<void> _addMarkers(
    NaverMapController controller,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final mapViewModel = ref.watch(mapViewModelProvider);
    final posts = mapViewModel;

    //controller.clearOverlays();

    final Set<String> newMarkerIds =
        posts.map((post) => post.postId.toString()).toSet();

    for (var post in posts) {
      final markerId = post.postId.toString();

      if (!currentMarkerIds.contains(markerId)) {
        // Add new markers
        NMarker marker;
        if (post.mediaURL != null && post.mediaURL!.isNotEmpty) {
          final nOverlayImage = await buildImageMarkerWidget(
            post.mediaURL!,
            post.disasterType!,
            context,
          );
          marker = CustomImageMarker(
            id: markerId,
            nOverlayImage: nOverlayImage,
            position: NLatLng(post.latitude!, post.longitude!),
            onTap: () {
              ref
                  .read(mapViewModelProvider.notifier)
                  .onMarkerTap(post, ref, controller);
            },
          );
        } else {
          marker = CustomMarker(
            id: markerId,
            eventType: post.disasterType!,
            position: NLatLng(post.latitude!, post.longitude!),
            onTap: () {
              ref
                  .read(mapViewModelProvider.notifier)
                  .onMarkerTap(post, ref, controller);
            },
          );
        }

        controller.addOverlay(marker);
        currentMarkerIds.add(markerId); // Track the added marker
      }
    }

    // Remove old markers
    // final markersToRemove = currentMarkerIds.difference(newMarkerIds);
    // for (final markerId in markersToRemove) {
    //   await controller.deleteOverlay(
    //     NOverlayInfo(
    //       type: NOverlayType.marker,
    //       id: markerId,
    //     ),
    //   );
    //   currentMarkerIds.remove(markerId); // Remove from current tracking
    // }
  }
}
