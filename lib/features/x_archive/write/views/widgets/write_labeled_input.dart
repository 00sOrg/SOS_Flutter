import 'package:flutter/material.dart';

class WriteLabeledInput extends StatelessWidget {
  final String label;
  final Widget widget;

  const WriteLabeledInput({super.key, required this.label, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF595959)
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        widget,
        const SizedBox(height: 24)
      ],
    );
  }
}
