import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_wrapper.dart';

class BottomSheetViewModel extends StateNotifier<double> {
  BottomSheetViewModel(this.ref) : super(0.2); // 기본적으로 바텀시트는 20% 열린 상태

  final StateNotifierProviderRef<BottomSheetViewModel, double> ref;
  PersistentBottomSheetController? _controller;
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  void toggleBottomSheet(BuildContext context) async {
    if (_controller == null) {
      // 바텀시트가 열려 있지 않은 경우, 바텀시트 열기
      _controller = _showNonModalBottomSheet(context);
      state = 0.2;
    } else if (state == 0.2) {
      // 바텀시트가 열려 있는 경우, 바텀시트를 닫기
      //_controller!.close();
      _controller = _showNonModalBottomSheet(context);
      ;
      state = 0.8;
    } else if (state == 0.8) {
      _controller = _showNonModalBottomSheet(context);
      ;
      state = 0.2;
    } else if (_controller != null && state == 0.0) {
      // 바텀시트가 닫혀 있지만 _controller가 null이 아닌 경우, 바텀시트 열기 (재사용)
      _controller = _showNonModalBottomSheet(context);
      state = 0.2;
    }
  }

  void closeBottomSheet() {
    if (_controller != null) {
      _controller!.close();
      _controller = null;
      state = 0.0;
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
          initialChildSize: sheetPercentage,
          minChildSize: 0.2, // Minimum height set to 20%
          maxChildSize: 0.8, // Maximum height set to 80%
          expand: false,
          builder: (context, scrollController) {
            double previousExtent = sheetPercentage;

            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                final extent = notification.extent;

                if (extent > previousExtent && extent >= 0.8) {
                  setSheetPercentage(0.8);
                } else if (extent < previousExtent && extent <= 0.2) {
                  setSheetPercentage(0.2);
                }

                previousExtent = extent;
                return true; // Prevent further propagation
              },
              child: BottomSheetWrapper(), // BottomSheetWrapper로 대체
            );
          },
        );
      },
    );

    controller.closed.then((_) {
      setSheetPercentage(0.2);
      _controller = null;
    });

    return controller;
  }

  void setSheetPercentage(double percentage) {
    if (percentage != state) {
      state = percentage;
    }
  }

  void navigateToPost(BuildContext context, int postId) {
    closeBottomSheet();
    context.go('/post/$postId');
  }
}

final bottomSheetViewModelProvider =
    StateNotifierProvider<BottomSheetViewModel, double>((ref) {
  return BottomSheetViewModel(ref);
});
