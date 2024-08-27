import 'package:flutter/material.dart';

class SettingLabledField extends StatelessWidget {
  final String label;
  final Widget child;
  final double labelGap;
  final double bottomPadding;
  const SettingLabledField({
    super.key,
    required this.label,
    required this.child,
    this.labelGap = 16,
    this.bottomPadding = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' $label',
          style: const TextStyle(
            fontSize: 16,
            height: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: labelGap),
        child,
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
