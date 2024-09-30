import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_contents.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HomePageBottomSheet extends ConsumerWidget {
  const HomePageBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(bottomSheetViewModelProvider.notifier);
    final bottomSheetState = ref.watch(bottomSheetViewModelProvider);

    return DraggableScrollableSheet(
      controller: viewModel.scrollableController, // 뷰모델의 controller 사용
      initialChildSize: bottomSheetState.sheetHeight, // 초기 높이는 상태에서 가져옴
      minChildSize: 0.15,
      maxChildSize: 0.75,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomSheetContent(scrollController: scrollController),
        );
      },
    );
  }
}
