import 'package:flutter/material.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_contents.dart';

class BottomSheetWrapper extends StatelessWidget {
  final ScrollController scrollController;

  const BottomSheetWrapper({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BottomSheetContent(scrollController: scrollController),
    );
  }
}
