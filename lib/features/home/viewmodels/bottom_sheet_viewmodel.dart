import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_wrapper.dart';
import 'package:sos/shared/models/post.dart';
import 'package:sos/features/post/viewmodels/post_list.dart'; // Import the dummy data

class BottomSheetViewModel extends StateNotifier<double> {
  BottomSheetViewModel() : super(0.15) {
    _fetchNearbyEvents();
  }

  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  bool _wasExpanded = false;
  List<Post> _nearbyEvents = [];

  List<Post> get nearbyEvents => _nearbyEvents;

  void _fetchNearbyEvents() {
    // 여기서 실제 API를 호출하는 대신, 더미 데이터를 사용합니다.
    _nearbyEvents = dummyPosts;
    state = state; // 상태를 트리거하여 UI 업데이트
  }

  void toggleBottomSheet() {
    if (_scrollableController.isAttached) {
      if (state == 0.0) {
        // 0.0 상태에서 0.15로 확장
        _scrollableController.animateTo(
          0.15,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        state = 0.15;
        _wasExpanded = false; // 아직 확장되지 않음
      } else if (state == 0.15 && !_wasExpanded) {
        // 0.15 상태에서 0.75로 확장
        _scrollableController.animateTo(
          0.75,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        state = 0.75;
        _wasExpanded = true; // 0.75로 확장됨
      } else if (state == 0.75) {
        // 0.75 상태에서 0.15로 축소
        _scrollableController.animateTo(
          0.15,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        state = 0.15;
        _wasExpanded = true; // 0.75에서 축소됨
      } else if (state == 0.15 && _wasExpanded) {
        // 0.75였다가 0.15일때 0.0으로 닫기
        _scrollableController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        state = 0.0;
        _wasExpanded = false; // 닫힘
      }
    }
  }

  void closeBottomSheet() {
    if (_scrollableController.isAttached) {
      _scrollableController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      state = 0.0;
    }
  }

  bool shouldShowStatus() {
    return state <= 0.15;
  }

  DraggableScrollableController get scrollableController =>
      _scrollableController;

  void navigateToPost(BuildContext context, int postId) {
    closeBottomSheet();
    context.push('/post/$postId'); // 포스트 페이지로 이동
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, double>((ref) {
  return BottomSheetViewModel();
});

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
