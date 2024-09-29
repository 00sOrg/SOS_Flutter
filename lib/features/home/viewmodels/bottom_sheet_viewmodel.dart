import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/repositories/home_repository.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/services/geolocator_service.dart';

class BottomSheetState {
  final Post? tappedPost;
  final List<Post> nearbyEvents;
  final double sheetHeight;
  final bool isViewingTappedPost;

  BottomSheetState({
    this.tappedPost,
    required this.nearbyEvents,
    required this.sheetHeight,
    this.isViewingTappedPost = false,
  });

  BottomSheetState copyWith({
    Post? tappedPost,
    List<Post>? nearbyEvents,
    double? sheetHeight,
    bool? isViewingTappedPost,
  }) {
    return BottomSheetState(
      tappedPost: tappedPost ?? this.tappedPost,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      sheetHeight: sheetHeight ?? this.sheetHeight,
      isViewingTappedPost: isViewingTappedPost ?? this.isViewingTappedPost,
    );
  }
}

class BottomSheetViewModel extends StateNotifier<BottomSheetState> {
  BottomSheetViewModel(this._homeRepository)
      : super(BottomSheetState(nearbyEvents: [], sheetHeight: 0.15));

  final HomeRepository _homeRepository;
  late DraggableScrollableController _scrollableController;
  bool _wasExpanded = false;

  void initState() {
    _scrollableController = DraggableScrollableController();
    fetchNearbyEvents();
  }

  @override
  void dispose() {
    _scrollableController.dispose();
    super.dispose();
  }

  Future<void> fetchNearbyEvents() async {
    final position = await GeolocatorService.getCurrentPosition();
    final lat = position.latitude;
    final lon = position.longitude;

    final nearbyEvents = await _homeRepository.getAllNearbyPosts(lat, lon);
    if (nearbyEvents != []) {
      state = state.copyWith(
          nearbyEvents: nearbyEvents,
          tappedPost: null,
          isViewingTappedPost: false);
    } else {
      state = state.copyWith(nearbyEvents: []);
    }
  }

  Future<void> toggleBottomSheet() async {
    if (!_scrollableController.isAttached) {
      return;
    }
    if (state.sheetHeight == 0.15) {
      await setBottomSheetHeight(0.75);
    } else if (state.sheetHeight == 0.75) {
      await setBottomSheetHeight(0.15);
    }
  }

  Future<void> setBottomSheetHeight(double height) async {
    await _scrollableController.animateTo(
      height,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    state = state.copyWith(sheetHeight: height);
  }

  DraggableScrollableController get scrollableController =>
      _scrollableController;

  void navigateToPost(BuildContext context, int postId) {
    setBottomSheetHeight(0.0);
    context.push('/post/$postId'); // 포스트 페이지로 이동
  }

  Future<void> fetchTappedPost(int postId) async {
    debugPrint('Tapped post: ${postId}');
    await setBottomSheetHeight(0.35);
    final postOverview = await _homeRepository.getPostOverviewById(postId);
    state = state.copyWith(tappedPost: postOverview, isViewingTappedPost: true);
  }

  Future<void> clearTappedPost() async {
    state = state.copyWith(tappedPost: null, isViewingTappedPost: false);
    debugPrint('Cleared tapped post');
    debugPrint('Tapped post: ${state.tappedPost}');
    await fetchNearbyEvents();
    await setBottomSheetHeight(0.151);
  }
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, BottomSheetState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return BottomSheetViewModel(homeRepository);
});
