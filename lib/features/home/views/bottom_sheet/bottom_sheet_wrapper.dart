import 'package:flutter/material.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_contents.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BottomSheetWrapper extends StatelessWidget {
  final ScrollController scrollController;

  const BottomSheetWrapper({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // 그림자 색상 및 투명도
            spreadRadius: 5, // 그림자 퍼짐 반경
            blurRadius: 15, // 그림자 블러 반경
            offset: Offset(0, -5), // 그림자 위치 조정 (x, y)
          ),
        ],
      ),
      child: BottomSheetContent(scrollController: scrollController),
    );
  }
}
