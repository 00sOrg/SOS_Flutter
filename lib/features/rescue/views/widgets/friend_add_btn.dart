import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class FriendAddBtn extends StatelessWidget {
  final double radius;
  final VoidCallback onTap;

  const FriendAddBtn({super.key, required this.onTap, required this.radius});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: const Color(0xFFFAFAFA),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 36,
              color: AppColors.textGray,
            ),
          )),
    );
  }
}
