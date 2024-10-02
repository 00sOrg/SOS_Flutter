import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/post/repositories/post_repository.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/services/location_service.dart';
import 'package:sos/shared/widgets/custom_snack_bar.dart';

class MapViewModel extends StateNotifier<List<Post>> {
  final PostRepository postRepository;
  MapViewModel(this.postRepository) : super([]);

  Future<void> fetchPostsForMap(
      String level, double latitude, double longitude, int zoom) async {
    final posts =
        await postRepository.getPostsForMap(level, latitude, longitude, zoom);
    if (posts != []) {
      state = posts;
    }
  }

  // Method to center map on a specific post
  void updateCameraToCenter(
    double latitude,
    double longitude,
    NaverMapController controller,
  ) {
    controller.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(latitude, longitude),
        zoom: 15,
      ),
    );
  }

  // Method to handle marker tap
  void onMarkerTap(Post post, WidgetRef ref, NaverMapController controller) {
    updateCameraToCenter(post.latitude!, post.longitude!, controller);

    ref
        .read(bottomSheetViewModelProvider.notifier)
        .fetchTappedPost(post.postId); // Notify bottom sheet
  }

  void onFriendMarkerTap(
      Friend friend, WidgetRef ref, NaverMapController controller) {
    updateCameraToCenter(friend.latitude!, friend.longitude!, controller);
    // Todo: 친구를 누르고 어떤 로직을 처리할지
  }

  Future<void> onLocationBtnTap(NaverMapController controller) async {
    final trackingMode = await controller.getLocationTrackingMode();

    // 다음 tracking 모드를 순차적으로 설정
    switch (trackingMode) {
      case NLocationTrackingMode.face:
        await controller.setLocationTrackingMode(NLocationTrackingMode.follow);
        break;
      case NLocationTrackingMode.follow:
        await controller
            .setLocationTrackingMode(NLocationTrackingMode.noFollow);
        break;
      case NLocationTrackingMode.noFollow:
        await controller.setLocationTrackingMode(NLocationTrackingMode.none);
        break;
      case NLocationTrackingMode.none:
        await controller.setLocationTrackingMode(NLocationTrackingMode.face);
        break;
    }
  }

  Future<void> onToggleSwitchTapped(NaverMapController controller) async {
    await controller.clearOverlays();
  }

  // 주소를 입력받아 지도에서 해당 위치로 이동하는 메소드
  Future<void> searchAndMoveMap(String address, NaverMapController controller,
      WidgetRef ref, BuildContext context) async {
    try {
      // API 호출로 검색된 주소 데이터 가져오기
      final locationService = LocationService();
      final response = await locationService.searchLocationByAddress(address);
      final addresses = response['addresses'] as List<dynamic>;

      // 검색된 주소가 있는 경우 좌표 추출 (위도: y, 경도: x)
      if (addresses.isNotEmpty) {
        final addressData = addresses[0];
        final double latitude = double.parse(addressData['y']);
        final double longitude = double.parse(addressData['x']);

        // 지도 이동: 지도의 중심을 해당 좌표로 이동
        updateCameraToCenter(latitude, longitude, controller);

        // 성공적인 좌표 변환 로그
        debugPrint('위치 찾음: ($latitude, $longitude)');
      } else {
        throw Exception('검색 결과가 없습니다.');
      }
    } catch (e) {
      // 오류 처리 (예: 주소를 찾을 수 없는 경우)
      debugPrint('주소 검색 중 오류 발생: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(text: '주소를 찾을 수 없습니다.'),
      );
    }
  }
}

final mapViewModelProvider =
    StateNotifierProvider<MapViewModel, List<Post>>((ref) {
  final homeRepository = ref.watch(postRepositoryProvider);
  return MapViewModel(homeRepository);
});
