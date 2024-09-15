import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/widgets/custom_marker.dart';
import 'package:sos/shared/models/location.dart';
import 'package:sos/shared/models/post.dart';

class MapWidget extends ConsumerWidget {
  final Location location;
  final List<Post> posts;
  late NaverMapController _controller;

  MapWidget({
    Key? key,
    required this.location,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NaverMap(
      options: NaverMapViewOptions(
        initialCameraPosition: NCameraPosition(
          target: NLatLng(location.latitude, location.longitude),
          zoom: 15,
          bearing: 0,
          tilt: 0,
        ),
      ),
      onMapReady: (controller) {
        _controller = controller; // Store the controller
        _addMarkers(controller, ref); // Add markers when the map is ready
      },
    );
  }

  // 마커를 추가하는 함수
  void _addMarkers(NaverMapController controller, WidgetRef ref) {
    for (var post in posts) {
      final marker = CustomMarker(
        id: post.postId.toString(),
        position: NLatLng(post.latitude!, post.longitude!),
        caption: NOverlayCaption(text: post.title),
        onTap: () {
          _onMarkerTap(post, ref); // 마커 탭 시 호출할 메서드
        },
      );

      controller.addOverlay(marker); // 지도에 마커 추가
    }
  }

// 마커 탭 시 호출되는 메서드
  void _onMarkerTap(Post post, WidgetRef ref) {
    debugPrint('Marker tapped: ${post.title} (id:${post.postId})');

    // 카메라를 마커의 좌표로 이동시키는 로직 추가
    _controller.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(post.latitude!, post.longitude!),
        zoom: 15,
      ),
    );

    // 바텀시트 등 UI에 포스트 정보를 표시하는 로직 추가 가능
    // Set the tapped post in the bottomSheetViewModel
    ref.read(bottomSheetViewModelProvider.notifier).tapPost(post);
  }
}

class DummyMapArea extends StatelessWidget {
  const DummyMapArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}
