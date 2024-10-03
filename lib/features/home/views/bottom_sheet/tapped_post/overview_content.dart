import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class OverviewContent extends StatelessWidget {
  final String? content;

  const OverviewContent({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    if (content == null || content!.isEmpty) {
      return const SizedBox.shrink(); // If empty, return an empty widget
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 30, bottom: 40),
      child: Container(
        alignment: Alignment.topLeft,
        child: SizedBox(
          child: Text(
            textAlign: TextAlign.justify,
            content!,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
