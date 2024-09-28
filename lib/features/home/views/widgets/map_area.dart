import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/home_viewmodel.dart';
import 'package:sos/features/home/viewmodels/mapController_viewmodel.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/features/home/views/widgets/custom_marker.dart';
import 'package:sos/shared/models/location.dart';

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
            controller.setLocationTrackingMode(NLocationTrackingMode.face);
            mapViewModel.fetchPostsForMap(
                level, currentLocation.latitude, currentLocation.longitude, 15);

            _addMarkers(controller, ref);
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

              _addMarkers(naverMapController, ref);
            }
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

  void _addMarkers(NaverMapController controller, WidgetRef ref) {
    final mapViewModel = ref.watch(mapViewModelProvider);
    final posts = mapViewModel;

    // Clear existing markers
    controller.clearOverlays();

    // Add markers for each post
    for (var post in posts) {
      final marker = CustomMarker(
        id: post.postId.toString(),
        eventType: post.disasterType!,
        position: NLatLng(post.latitude!, post.longitude!),
        onTap: () {
          ref
              .read(mapViewModelProvider.notifier)
              .onMarkerTap(post, ref, controller);
        },
      );
      controller.addOverlay(marker);
    }
  }
}
