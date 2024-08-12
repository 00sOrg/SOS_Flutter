import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/contents.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/shared/utils/log_util.dart';

final DraggableScrollableController _scrollableController =
    DraggableScrollableController();

void showNonModalBottomSheet(BuildContext context, WidgetRef ref) {
  final sheetPercentage = ref.read(bottomSheetViewModelProvider);

  showBottomSheet(
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

              // 로그 추가
              debugPrint('Current extent: $extent');

              if (extent > previousExtent && previousExtent >= 0.2) {
                sheetNotifier.setSheetPercentage(0.8);
              } else if (extent < previousExtent && previousExtent <= 0.8) {
                sheetNotifier.setSheetPercentage(0.2);
              } else if (extent <= 0.2 && previousExtent > 0.2) {
                // extent가 0.2 이하로 내려가면 시트를 닫음
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
  ).closed.then((_) {
    LogUtil.e("Bottom sheet closed");
    ref.read(bottomSheetViewModelProvider.notifier).setSheetPercentage(0.2);
  });
}
