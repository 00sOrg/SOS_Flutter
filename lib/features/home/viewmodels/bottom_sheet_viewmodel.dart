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

  BottomSheetState({
    this.tappedPost,
    required this.nearbyEvents,
    required this.sheetHeight,
  });

  BottomSheetState copyWith({
    Post? tappedPost,
    List<Post>? nearbyEvents,
    double? sheetHeight,
  }) {
    return BottomSheetState(
      tappedPost: tappedPost ?? this.tappedPost,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      sheetHeight: sheetHeight ?? this.sheetHeight,
    );
  }
}

class BottomSheetViewModel extends StateNotifier<BottomSheetState> {
  final HomeRepository _homeRepository;

  BottomSheetViewModel(this._homeRepository)
      : super(BottomSheetState(nearbyEvents: [], sheetHeight: 0.15)) {
    _fetchNearbyEvents();
  }

  DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  bool _wasExpanded = false;

  @override
  void dispose() {
    _scrollableController =
        DraggableScrollableController(); // Reset the controller
    super.dispose();
  }

  Future<void> _fetchNearbyEvents() async {
    final position = await GeolocatorService.getCurrentPosition();
    final lat = position.latitude;
    final lon = position.longitude;

    final nearbyEvents = await _homeRepository.getAllNearbyPosts(lat, lon);
    if (nearbyEvents != null) {
      state = state.copyWith(nearbyEvents: nearbyEvents);
    }
  }

  void toggleBottomSheet() {
    // Ensure the controller is attached before calling animateTo
    if (!_scrollableController.isAttached) {
      return;
    }
    if (state.sheetHeight == 0.0) {
      _scrollableController.animateTo(
        0.15,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(sheetHeight: 0.15);
      _wasExpanded = false;
    } else if (state.sheetHeight == 0.15 && !_wasExpanded) {
      _scrollableController.animateTo(
        0.75,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(sheetHeight: 0.75);
      _wasExpanded = true;
    } else if (state.sheetHeight == 0.75) {
      _scrollableController.animateTo(
        0.15,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(sheetHeight: 0.15);
      _wasExpanded = true;
    } else if (state.sheetHeight == 0.15 && _wasExpanded) {
      _scrollableController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(sheetHeight: 0.0);
      _wasExpanded = false;
    }
  }

  void closeBottomSheet() {
    _scrollableController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    state = state.copyWith(sheetHeight: 0.0);
  }

  DraggableScrollableController get scrollableController =>
      _scrollableController;

  void navigateToPost(BuildContext context, int postId) {
    closeBottomSheet();
    context.push('/post/$postId'); // 포스트 페이지로 이동
  }

  void tapPost(Post post) {
    state = state.copyWith(tappedPost: post);
  }

  void clearTappedPost() {
    state = state.copyWith(tappedPost: null);
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
