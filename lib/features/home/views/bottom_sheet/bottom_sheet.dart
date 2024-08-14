import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/contents.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/utils/log_util.dart';

final DraggableScrollableController _scrollableController =
    DraggableScrollableController();

final bottomSheetControllerProvider =
    StateNotifierProvider<BottomSheetController, bool>((ref) {
  return BottomSheetController(ref);
});

class BottomSheetController extends StateNotifier<bool> {
  final StateNotifierProviderRef<BottomSheetController, bool> ref;
  PersistentBottomSheetController? _controller;

  BottomSheetController(this.ref) : super(false);

  void toggleBottomSheet(BuildContext context) {
    if (_controller == null) {
      // 바텀시트가 열려 있지 않은 경우, 바텀시트 열기
      _controller = showNonModalBottomSheet(context);
      state = true;
    } else if (state == false) {
      // 바텀시트가 닫혀 있지만 _controller가 null이 아닌 경우 (안정성을 위해 추가)
      _controller = showNonModalBottomSheet(context);
      state = true;
    } else {
      // 바텀시트가 열려 있는 경우, 바텀시트를 닫기
      _controller!.close();
      _controller = null;
      state = false;
    }
  }

  void closeBottomSheet() {
    if (_controller != null) {
      _controller!.close();
      _controller = null;
      state = false;
    }
  }

  PersistentBottomSheetController showNonModalBottomSheet(
      BuildContext context) {
    final sheetPercentage = ref.read(bottomSheetViewModelProvider);

    final controller = showBottomSheet(
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: _scrollableController,
          initialChildSize: sheetPercentage,
          minChildSize: 0.0, // 최소 크기 0%
          maxChildSize: 0.8, // 최대 크기 80%
          expand: false,
          builder: (context, scrollController) {
            double previousExtent = sheetPercentage;

            return NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                final extent = notification.extent;
                final sheetNotifier =
                    ref.read(bottomSheetViewModelProvider.notifier);

                debugPrint('Current extent: $extent');

                if (extent > previousExtent && previousExtent >= 0.2) {
                  sheetNotifier.setSheetPercentage(0.8);
                } else if (extent < previousExtent && previousExtent <= 0.8) {
                  sheetNotifier.setSheetPercentage(0.2);
                } else if (extent <= 0.2 && previousExtent > 0.2) {
                  Navigator.of(context).pop(); // 바텀시트 닫기
                }
                previousExtent = extent;
                return true;
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: BottomSheetContent(scrollController: scrollController),
              ),
            );
          },
        );
      },
    );

    controller.closed.then((_) {
      LogUtil.e("Bottom sheet closed");
      ref.read(bottomSheetViewModelProvider.notifier).setSheetPercentage(0.2);
      _controller = null;
      state = false;
    });

    return controller;
  }
}
