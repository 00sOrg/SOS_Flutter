import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/providers/home_repo_provider.dart';
import 'package:sos/features/home/repositories/home_repository.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/shared/services/geolocator_service.dart';

class BottomSheetState {
  final Post? tappedPost;
  final List<Post> nearbyEvents;
  final double sheetHeight;
  final bool isViewingTappedPost;
  final NLatLng? nLatLng;

  BottomSheetState({
    this.tappedPost,
    required this.nearbyEvents,
    required this.sheetHeight,
    this.isViewingTappedPost = false,
    this.nLatLng, //지도 상 현재 위치 (초기에는 내 현재 위치로 설정)
  });

  BottomSheetState copyWith({
    Post? tappedPost,
    List<Post>? nearbyEvents,
    double? sheetHeight,
    bool? isViewingTappedPost,
    NLatLng? nLatLng,
  }) {
    return BottomSheetState(
      tappedPost: tappedPost ?? this.tappedPost,
      nearbyEvents: nearbyEvents ?? this.nearbyEvents,
      sheetHeight: sheetHeight ?? this.sheetHeight,
      isViewingTappedPost: isViewingTappedPost ?? this.isViewingTappedPost,
      nLatLng: nLatLng ?? this.nLatLng,
    );
  }
}

class BottomSheetViewModel extends StateNotifier<BottomSheetState> {
  BottomSheetViewModel(this._homeRepository)
      : super(BottomSheetState(nearbyEvents: [], sheetHeight: 0.15));

  final HomeRepository _homeRepository;
  late DraggableScrollableController _scrollableController;

  DraggableScrollableController get scrollableController =>
      _scrollableController;

  Future<void> initState() async {
    _scrollableController = DraggableScrollableController();

    final position = await GeolocatorService.getCurrentPosition();
    final lat = position.latitude;
    final lng = position.longitude;
    await fetchNearbyEvents(lat, lng);
  }

  @override
  void dispose() {
    _scrollableController.dispose();
    super.dispose();
  }

  Future<void> fetchNearbyEvents(double lat, double lng) async {
    final nearbyEvents = await _homeRepository.getAllNearbyPosts(lat, lng);
    if (nearbyEvents != []) {
      state = state.copyWith(
          nearbyEvents: nearbyEvents,
          tappedPost: null,
          isViewingTappedPost: false);
    } else {
      state = state.copyWith(nearbyEvents: []);
    }

    updateNLatLng(NLatLng(lat, lng));
  }

  toggleBottomSheet() {
    if (!_scrollableController.isAttached) {
      return;
    }
    if (state.sheetHeight == 0.15) {
      setBottomSheetHeight(0.75);
    } else if (state.sheetHeight == 0.75) {
      setBottomSheetHeight(0.15);
    }
  }

  setBottomSheetHeight(double height) {
    _scrollableController.animateTo(
      height,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    state = state.copyWith(sheetHeight: height);
  }

  void navigateToPost(BuildContext context, int postId) {
    context.push('/post/$postId');
  }

  Future<void> fetchTappedPost(int postId) async {
    setBottomSheetHeight(0.36);
    await Future.delayed(const Duration(milliseconds: 200));
    final postOverview = await _homeRepository.getPostOverviewById(postId);
    state = state.copyWith(tappedPost: postOverview, isViewingTappedPost: true);
  }

  Future<void> clearTappedPost() async {
    setBottomSheetHeight(0.15);
    await Future.delayed(const Duration(milliseconds: 400));
    state = state.copyWith(tappedPost: null, isViewingTappedPost: false);
  }

  void updateNLatLng(NLatLng newNLatLng) {
    state = state.copyWith(nLatLng: newNLatLng);
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, BottomSheetState>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return BottomSheetViewModel(homeRepository);
});
