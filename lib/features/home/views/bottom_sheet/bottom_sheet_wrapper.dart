import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sos/features/home/views/bottom_sheet/bottom_sheet_contents.dart';

class BottomSheetWrapper extends ConsumerWidget {
  final ScrollController scrollController; // Add this line

  const BottomSheetWrapper(
      {super.key, required this.scrollController}); // Modify constructor

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomSheetContent(
          scrollController: scrollController), // Pass the controller here
    );
  }
}
