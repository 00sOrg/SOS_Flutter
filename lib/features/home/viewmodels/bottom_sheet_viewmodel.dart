import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_wrapper.dart';

class BottomSheetViewModel extends StateNotifier<double> {
  BottomSheetViewModel(this.ref) : super(0.0); // 기본적으로 바텀시트는 20% 열린 상태

  final StateNotifierProviderRef<BottomSheetViewModel, double> ref;
  PersistentBottomSheetController? _controller;
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  void openBottomSheet(BuildContext context) {
    if (_controller == null) {
      // 바텀시트가 열려 있지 않은 경우, 바텀시트 열기
      _controller = _showNonModalBottomSheet(context);
      state = 0.2;
    } else if (state == 0.2) {
      _scrollableController.animateTo(
        0.75,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setSheetPercentage(0.75);
    } else if (state == 0.75) {
      _scrollableController.animateTo(
        0.2,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setSheetPercentage(0.2);
    }
  }

  void closeBottomSheet() {
    if (_controller != null) {
      final controller = _controller!;
      _controller = null; // Immediately set _controller to null
      setSheetPercentage(0.0); // Manually update state
      controller.close(); // Close the controller after setting it to null
    }
  }

  PersistentBottomSheetController _showNonModalBottomSheet(
      BuildContext context) {
    final sheetPercentage = state;

    final controller = showBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _scrollableController,
          initialChildSize: 0.2, // Always start at 20% when reopening
          minChildSize: 0.0,
          maxChildSize: 0.75,
          expand: false,
          builder: (context, scrollController) {
            double previousExtent = sheetPercentage;

            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                final extent = notification.extent;

                debugPrint('$extent');

                if (extent < previousExtent && extent < 0.75) {
                  setSheetPercentage(0.2);
                } else if (extent < 0.2) {
                  setSheetPercentage(0.0);
                  closeBottomSheet(); // Close the bottom sheet when dragged to or below 0.2
                }

                previousExtent = extent;
                return true; // Prevent further propagation
              },
              child: BottomSheetWrapper(scrollController: scrollController),
            );
          },
        );
      },
    );

    // controller.closed.then((_) {
    //   // Ensure the state is reset only if the controller is already null
    //   if (_controller == null) {
    //     setSheetPercentage(0.0);
    //   }
    // });

    return controller;
  }

  void setSheetPercentage(double percentage) {
    if (percentage != state) {
      state = percentage;
    }
  }

  void navigateToPost(BuildContext context, int postId) {
    if (_controller != null) {
      final controller = _controller!;
      _controller = null; // Immediately set _controller to null
      controller.close(); // Close the bottom sheet
      state = 0.2; // Set state to 0.2 after closing the bottom sheet
    } else {
      state = 0.2; // Ensure state is set to 0.2 if the controller is null
    }
    context.go('/post/$postId'); // Navigate to the post
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, double>((ref) {
  return BottomSheetViewModel(ref);
});
