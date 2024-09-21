import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/home/repositories/home_repository.dart';

class MapViewModel extends StateNotifier<List<Post>> {
  final HomeRepository homeRepository;
  MapViewModel(this.homeRepository) : super([]);

  Future<void> fetchPostsForMap(
      String level, double latitude, double longitude) async {
    final posts =
        await homeRepository.getPostsForMap(level, latitude, longitude);
    if (posts != null) {
      state = posts;
    }
  }

  // Method to center map on a specific post
  void centerMapOnPost(Post post, NaverMapController controller) {
    controller.updateCamera(
      NCameraUpdate.scrollAndZoomTo(
        target: NLatLng(post.latitude!, post.longitude!),
        zoom: 15,
      ),
    );
  }

  // Method to handle marker tap
  void onMarkerTap(Post post, WidgetRef ref, NaverMapController controller) {
    centerMapOnPost(post, controller);
    ref
        .read(bottomSheetViewModelProvider.notifier)
        .tapPost(post); // Notify bottom sheet
  }
}

final mapViewModelProvider =
    StateNotifierProvider<MapViewModel, List<Post>>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return MapViewModel(homeRepository);
});
