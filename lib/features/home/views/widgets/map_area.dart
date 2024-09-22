import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/map_viewmodel.dart';
import 'package:sos/features/home/views/widgets/custom_marker.dart';
import 'package:sos/shared/models/location.dart';

class MapWidget extends ConsumerWidget {
  final Location currentLocation;
  final String level;
  late NaverMapController _controller;

// TODO: 에러 고치기... 채리야 도와줘...
// 예외가 발생했습니다. LateError (LateInitializationError: Field '_controller@99315947' has not been initialized.)

  MapWidget({
    Key? key,
    required this.currentLocation,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapViewModel = ref.read(mapViewModelProvider.notifier);

    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
      ),
      onMapReady: (NaverMapController controller) {
        _controller = controller;
        mapViewModel.fetchPostsForMap(level, currentLocation.latitude,
            currentLocation.longitude, 15); // Use level here
        _addMarkers(controller, ref);
      },
      onCameraIdle: () async {
        final cameraPosition = await _controller.getCameraPosition();
        final zoomLevel = cameraPosition.zoom.round();
        mapViewModel.fetchPostsForMap(level, cameraPosition.target.latitude,
            cameraPosition.target.longitude, zoomLevel); // Use level here
        _addMarkers(_controller, ref);
      },
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
