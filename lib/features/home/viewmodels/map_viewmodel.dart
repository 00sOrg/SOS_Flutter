import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/providers/home_repo_provider.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/models/friend.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/home/repositories/home_repository.dart';

class MapViewModel extends StateNotifier<List<Post>> {
  final HomeRepository homeRepository;
  MapViewModel(this.homeRepository) : super([]);

  Future<void> fetchPostsForMap(
      String level, double latitude, double longitude, int zoom) async {
    final posts =
        await homeRepository.getPostsForMap(level, latitude, longitude, zoom);
    if (posts != []) {
      state = posts;
    }
  }

  // Method to center map on a specific post
  void centerMapOnPost(
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
    centerMapOnPost(post.latitude!, post.longitude!, controller);

    ref
        .read(bottomSheetViewModelProvider.notifier)
        .fetchTappedPost(post.postId); // Notify bottom sheet
  }

  void onFriendMarkerTap(
      Friend friend, WidgetRef ref, NaverMapController controller) {
    centerMapOnPost(friend.latitude!, friend.longitude!, controller);
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
}

final mapViewModelProvider =
    StateNotifierProvider<MapViewModel, List<Post>>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return MapViewModel(homeRepository);
});
