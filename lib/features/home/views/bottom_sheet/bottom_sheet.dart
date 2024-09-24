import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/viewmodels/bottom_sheet_viewmodel.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_contents.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HomePageBottomSheet extends ConsumerWidget {
  const HomePageBottomSheet({super.key});

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
