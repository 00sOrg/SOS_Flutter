import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HandleBar extends StatelessWidget {
  const HandleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 10),
      child: Container(
        height: 4,
        width: 94,
        decoration: BoxDecoration(
          color: AppColors.textGray,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
