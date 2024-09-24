import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class BoardTagGrid extends StatelessWidget {
  final List<String> items;
  const BoardTagGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final List<String> oddItems = [];
    final List<String> evenItems = [];

    for (int i = 0; i < items.length; i++) {
      if (i % 2 == 0) {
        oddItems.add(items[i]);
      } else {
        evenItems.add(items[i]);
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: oddItems
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: tagBlock(text: item),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: evenItems
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: tagBlock(text: item),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget tagBlock({Widget? icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0017a7),
              AppColors.blue,
            ]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // icon ?? SizedBox.shrink(),
          const Icon(
            Icons.house,
            color: AppColors.white,
            size: 16, // Icon size
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
