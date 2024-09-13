import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_list.dart'; // Import the dummy data

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
  BottomSheetViewModel()
      : super(BottomSheetState(nearbyEvents: [], sheetHeight: 0.15)) {
    _fetchNearbyEvents();
  }

  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  bool _wasExpanded = false;

  void _fetchNearbyEvents() {
    state = state.copyWith(nearbyEvents: dummyPosts);
  }

  void tapPost(Post post) {
    state = state.copyWith(tappedPost: post);
  }

  void clearTappedPost() {
    state = state.copyWith(tappedPost: null);
  }

  void toggleBottomSheet() {
    if (_scrollableController.isAttached) {
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
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, BottomSheetState>(
        (ref) => BottomSheetViewModel());

class HomePageBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(bottomSheetViewModelProvider.notifier);

    return DraggableScrollableSheet(
      controller: viewModel.scrollableController,
      initialChildSize: 0.15, // 처음에 20%로 열리도록 설정
      minChildSize: 0.0, // 바텀시트가 최소로 줄어들 때
      maxChildSize: 0.75, // 최대 75%까지 열리도록 설정
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return BottomSheetWrapper(scrollController: scrollController);
      },
    );
  }
}
