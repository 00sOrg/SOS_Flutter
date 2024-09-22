import 'package:flutter/material.dart';
import 'package:sos/shared/styles/global_styles.dart';

class HeaderBtn extends StatelessWidget {
  final VoidCallback onTap;
  final Widget icon;

  const HeaderBtn({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
    );
  }
}
